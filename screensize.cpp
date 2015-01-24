#include "screensize.h"
#include <QApplication>
#include "QDesktopWidget"
#include <math.h>
#include <QVector>
#include <QFile>
#include <QDebug>
#include <QTimer>


struct trian{
    QPoint v1;
    QPoint v2;
    QPoint v3;
};

struct actionTime{  // точки срабатывания. секунда игры делится на 20, если соотв. элемент true, то объект исполняет действие
    bool t[20];
};

struct sprite{
    int     x;
    int     y;
    int     width;
    int     height;
    int     poligon1;   // основной полигон
    int     poligon2;   // полигон второго состояния
    int     poligon;    // активный полигон
    int     speedX;
    int     speedY;
    double  kf;         // масштаб к полигону
    bool    inUse;      // используется в текущей картинке
    bool    visible;
    bool    action;     // активный
    double  power;      // мощность выстрела
    double  xShoot;     // точка выстрела
    double  yShoot;
    double  angle;      // угол выстрела
    bool    go;         // движимость
    int     type;       // тип
    actionTime repeat;  // частота срабатывания
    int     lastTime;   // предыдущее срабатывание в точке lfstTime
    bool    planet;     // часть планеты (элемент ландшафта)
    int     sheep;      // реакция на столкновение с кораблем
};

struct livel{  // единица описания уровня
    int    time;
    int    type;
    double x;
    double y;
};

int     plg=0;                              // количество загруженных полигонов
std::vector<std::vector<trian> >objts;      // массив полигонов
std::vector<QString> plgImage;              // картинки полигонов
int     rn=0;                               // переменная для увеличения разброса генератора случайных чисел
bool    bls[20]={false,false,false,false,false,false,false,false,false,false,
                false,false,false,false,false,false,false,false,false,false}; // массив летящих ядер
double     blsX[20]={0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0};     // X
double     blsY[20]={0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0};     // Y
double  blsF[20]={0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0};     // сила, с которой летит ядро (или скорость, если так понятнее) (+)вверх, (-)вниз
std::vector <double> map;                   // карта уровня
int     mapPoint=0;                         // указатель на карту (очередной элемент для выдачи)
int     wScreen,hScreen;                    // размеры экрана

int     sl;                                 // длина секунды /10

std::vector<sprite> templ;                   // массив шаблонов объектов
std::vector<livel> liv;                      // текущий уровень
int     timeG=0;                             //
int     spkf=30000;                          // коэф. скорости
double kWidth,kHeight;                      // масштабы координат к родному размеру экрана, т.е. к 1280x1024
double timeW=12.8;                          // время прохождения стационарных объектов через стандартный экран



QTimer *tm;

actionTime getActTime(QString ln){  // "распоковать" строку ln и вернуть значение actionTime
    // при вызове к строке обязательно добавить ","
    actionTime at;
    for(int i=0;i<20;i++)at.t[i]=false;
    int j=0;
    for(int i=0;i<=ln.length();i++){
        if(ln.mid(i,1)==","){
            int t=ln.mid(j,i-j).toInt();
            j=i+1;
            at.t[t]=true;
        }
    }
    return at;
}

screenSize::screenSize(QObject *parent) : QObject(parent){
    wScreen=QApplication::desktop()->width();
    hScreen=QApplication::desktop()->height();
    kWidth=double(wScreen)/1280.0;
    kHeight=double(hScreen)/1024.0;
    loadObj();
    loadObj2();
    sl=(wScreen/500)*5;
    // вычисление коэф. скорости
    double w1=1280*hScreen/1024;
    spkf=2000.0*timeW*(double(wScreen)/w1); //                30000.0/(1280.0/double(wScreen));
}

int screenSize::getSpeedKf()
{
    return spkf;
}

screenSize::~screenSize(){}

int screenSize::screenWidth(){return wScreen;}

int screenSize::screenHeight(){return hScreen;}

void screenSize::loadObj() // загрузка полигонов
{
    QFile boss(":/poligons/plgs");
    QString ln;
    QByteArray line;
    QPoint cen,v3,v2,v1;
    trian trn;
    int fase=0;
      if (!boss.open(QIODevice::ReadOnly | QIODevice::Text))
          qDebug() << "can't open boss file";
  else{
          while (!boss.atEnd()) {
              line = boss.readLine();
              ln=QString::fromLatin1(line).trimmed();
              if(ln!=""){
                  QFile ob(":/poligons/p"+ln);
                  if (!ob.open(QIODevice::ReadOnly | QIODevice::Text))
                      qDebug() << "can't open ob file :/poligons/p"+ln;
                  else{ // Загрузка полигона
                      objts.resize(++plg);
                      fase=0;
                      line=ob.readLine();
                      plgImage.push_back(QString::fromLatin1(line).trimmed());
                      while (!ob.atEnd()) {
                         line=ob.readLine();
                         ln=QString::fromLatin1(line).trimmed();                     
                         if(ln.left(1)!="#" && ln.length()>2){ // это не комментарий - обрабатываем
                             switch (fase) {
                             case 0:
                                 cen=pointFromStr(ln);
                                 fase++;
                                 break;
                             case 1:
                                 v1=v2=pointFromStr(ln);
                                 fase++;
                                 break;
                             case 2:
                                 v3=pointFromStr(ln);
                                 trn.v1=cen;
                                 trn.v2=v2;
                                 trn.v3=v3;
                                 objts[plg-1].push_back(trn);
                                 v2=v3;
                             default:
                                 break;
                             }
                         }
                      }
                      trn.v1=cen;
                      trn.v2=v2;
                      trn.v3=v1;
                      objts[plg-1].push_back(trn);
                  }
              }

          }
      }
}

int getKey(QString ln) // получить код ключа для распаковки строки
{
    int i=ln.indexOf("=");
    QString s=ln.left(i);
    if(s=="x")return 0;
    if(s=="y")return 1;
    if(s=="speedx")return 2;
    if(s=="speedy")return 3;
    if(s=="power")return 4;
    if(s=="angle")return 5;
    if(s=="plg1")return 6;
    if(s=="plg2")return 7;
    if(s=="shootx")return 8;
    if(s=="shooty")return 9;
    if(s=="acttime")return 10;
    if(s=="planet")return 11;
    if(s=="sheep")return 12;
    return 100;
}

double getDouble(QString s, int i)
{
    int j=0;
    switch (i) {
    case 0:
        j=2;
        break;
    case 1:
        j=2;
        break;
    case 4:
        j=6;
        break;
    case 5:
        j=6;
        break;
    case 8:
        j=7;
        break;
    case 9:
        j=7;
        break;
    default:
        break;
    }
    return s.right(s.length()-j).toDouble();
}

int getInt(QString s, int i)
{
    int j=0;
    switch (i) {
    case 2:
        j=7;
        break;
    case 3:
        j=7;
        break;
    case 6:
        j=5;
        break;
    case 7:
        j=5;
        break;
    case 12:
        j=6;
        break;
    default:
        break;
    }
    return s.right(s.length()-j).toInt();
}
QString getString(QString s, int i)
{
    int j=0;
    switch (i) {
    case 10:
        j=8;
        break;
    default:
        break;
    }
    return s.right(s.length()-j);
}

bool getBool(QString s)
{
    return s.right(4)=="true";
}

void screenSize::loadObj2() // загрузка типовых шаблонов объектов
{
    QFile boss(":/obj/objs");
    QString ln;
    QByteArray line;
    sprite sp;
      if (!boss.open(QIODevice::ReadOnly | QIODevice::Text))
          qDebug() << "can't open objs file";
  else{
          while (!boss.atEnd()) {
              line = boss.readLine();
              ln=QString::fromLatin1(line).trimmed();
              if(ln!=""){
                  QFile ob(":/obj/"+ln);
                  if (!ob.open(QIODevice::ReadOnly | QIODevice::Text))
                      qDebug() << "can't open ob file :/obj/"+ln;
                  else{ // Загрузка шаблона
                      while (!ob.atEnd()){
                          line=ob.readLine();
                          ln=QString::fromLatin1(line).trimmed();
                          switch (getKey(ln)) {
                          case 0:
                              sp.width=hScreen*getDouble(ln,0);
                              break;
                          case 1:
                              sp.height=sp.width*getDouble(ln,1);
                              break;
                          case 2:
                              sp.speedX=getInt(ln,2);
                              break;
                          case 3:
                              sp.speedY=getInt(ln,3);
                              break;
                          case 4:
                              sp.power=getDouble(ln,4);
                              break;
                          case 5:
                              sp.angle=getDouble(ln,5);
                              break;
                          case 6:
                              sp.poligon1=getInt(ln,6);
                              break;
                          case 7:
                              sp.poligon2=getInt(ln,7);
                              break;
                          case 8:
                              sp.xShoot=getDouble(ln,8);
                              break;
                          case 9:
                              sp.yShoot=getDouble(ln,8);
                              break;
                          case 10:
                              sp.repeat=getActTime(getString(ln,10)+",");
                              break;
                          case 11:
                              sp.planet=getBool(ln);
                              break;
                          case 12:
                              sp.sheep=getInt(ln,12);
                              break;
                          }
                      }
                      sp.kf=double(getPoligonWidth(sp.poligon1))/double(sp.width);
                      templ.push_back(sp);
                  }
              }

          }
      }
}

int screenSize::getWithSheep(int i)
{
    return templ[i].sheep;
}


livel getFromStr(QString ln)
{
    livel lv;
    int i=ln.indexOf(";");
    lv.time=ln.left(i).toInt();
    int j=ln.indexOf(";",++i);
    lv.type=ln.mid(i,j-i).toInt();
    i=j;
    j=ln.indexOf(";",++i);
    lv.x=ln.mid(i,j-i).toDouble();
    lv.y=ln.right(ln.length()-j-1).toDouble();
    return lv;
}

void screenSize::loadLivel(int index)
{
    QFile boss(":/maps/liv"+QString::number(index));
    QString ln;
    liv.clear();
    if (!boss.open(QIODevice::ReadOnly | QIODevice::Text))
          qDebug() << "can't open map file";
  else{
          while (!boss.atEnd()) {
              ln=QString::fromLatin1(boss.readLine()).trimmed();
              if(ln.left(1)!="#" && ln.length()>3){
                  liv.push_back(getFromStr(ln));
              }
          }
    }
}



void screenSize::setObj(int time, int tsheft)
// установка нового объекта. из карты берутся объекты с соотв. меткой времени
{
    bool life;
    for(int i=0;i<int(liv.size());i++){
        if(liv[i].time==time && liv[i].x==tsheft){
                int j=liv[i].type-1;
                life=(templ[j].power>0);
                emit drawSprite(j,wScreen,liv[i].y*kHeight,templ[j].width,templ[j].height,
                                getImage(templ[j].poligon1),life,templ[j].speedX,
                                templ[j].poligon1,templ[j].kf);
            }
        }
}

QPoint screenSize::pointFromStr(QString st)
{
    int i=st.indexOf(",");
    int x=st.left(i).toInt();
    int y=st.right(st.length()-i-1).toInt();
    return QPoint(x,y);
}

int screenSize::getSecondPiligon(int i)
{
    return templ[i].poligon2;
}

void screenSize::chPoligon(int index)
{
    index--;
    if(templ[index].poligon2==0){
        return;
    }
    templ[index].poligon=templ[index].poligon2;
    templ[index].kf=getPoligonWidth(templ[index].poligon)/double(templ[index].width);
    emit drawSprite(index+1, templ[index].x, templ[index].y, templ[index].width, templ[index].height,
                      getImage(templ[index].poligon),false,templ[index].speedX,
                    templ[index].poligon,
                    double(getPoligonWidth(templ[index].poligon))/double(templ[index].width));
}

bool screenSize::toImpos(int p1, int p1x, int p1y, double k1, int index)
{
    index--;
    return imposition(p1,p1x,p1y,k1,templ[index].poligon,templ[index].x,templ[index].y,templ[index].kf);

}

bool screenSize::imposition(int p1, int p1x, int p1y, double k1, int p2, int p2x, int p2y, double k2)
{
    double x0,x1,x2,x3;
    double y0,y1,y2,y3;
    double a1,a2,a3;
    for(int i=0;i<int(objts[p1].size());i++){
        x0=objts[p1][i].v2.x()/k1+p1x;
        y0=objts[p1][i].v2.y()/k1+p1y;
        for(int j=0;j<int(objts[p2].size());j++){
            x1=objts[p2][j].v1.x()/k2+p2x;
            y1=objts[p2][j].v1.y()/k2+p2y;
            x2=objts[p2][j].v2.x()/k2+p2x;
            y2=objts[p2][j].v2.y()/k2+p2y;
            x3=objts[p2][j].v3.x()/k2+p2x;
            y3=objts[p2][j].v3.y()/k2+p2y;
            a1=(x1-x0)*(y2-y1)-(x2-x1)*(y1-y0);
            a2=(x2-x0)*(y3-y2)-(x3-x2)*(y2-y0);
            a3=(x3-x0)*(y1-y3)-(x1-x3)*(y3-y0);
            if((a1<0 && a2<0 && a3<0)||(a1>0 && a2>0 && a3>0)) return true;
        }
    }
    return false;
}

int screenSize::getRND(int h)
{
    switch (rn++) {
    case 0:
        return rand() % h;
        break;
    case 1:
        return h;
        break;
    case 2:
        return rand() % h;
        break;
    case 3:
        return h/2;
        break;
    case 4:
        return rand() % h;
        break;
    case 5:
        rn=0;
        return 0;
        break;
    }
    return rand() % h;
}

QString screenSize::getImage(int pol) // pol - номер полигона, возвр. путь к соответствующей картинке
{
    return "qrc:/images/"+plgImage[pol];
}

int screenSize::getPoligonWidth(int pol)
{
    int r=0;
    for(int i=0;i<int(objts[pol].size());i++){
        if(objts[pol][i].v2.x()>r)r=objts[pol][i].v2.x();
    }
    return r;
}

void screenSize::incTime()
{
    timeG++;
    if(timeG>19){
        timeG=0;
        for(int i=0;i<20;i++)templ[i].lastTime=20;
    }
}

bool screenSize::actPoint(int index, int p)
{
    return templ[index].repeat.t[p];
}

int screenSize::action2(int index,int x,int y)
{  
    switch (index) {
        case 1:
            return shootBoll(x*templ[index].xShoot,
                      y*templ[index].yShoot,
                      hScreen/templ[index].power);
            break;
        case 2:
            return shootBoll(x*templ[index].xShoot,
                      y*templ[index].yShoot,
                      hScreen/templ[index].power);
            break;
        default:
            return 0;
            break;
        }
    return 0;
}

int screenSize::shootBoll(int x, int y, int f) // регистрация ядер
{
    for(int i=0;i<20;i++){
        if(!bls[i]){
            bls[i]=true;
            blsX[i]=x;
            blsY[i]=y;
            blsF[i]=f;
            return i+1;
        }
    }
    qDebug()<< "Нет свободных ядер для выстрела";
    return 0;
}

bool screenSize::getXYBoll(int index) // вычислить очередные координаты ядра
// если ядро улетело с экрана, то освободить место в массиве и послать false,
// если ядро еще на экране, то вернуть true
{
    blsX[--index]-=wScreen/200;
    if(blsF[index]!=0)blsY[index]-=blsF[index]/2;
    blsF[index]-=double(hScreen)/20500.0; //высота вылета ядра. Чем больше делитель, тем выше
    if(blsX[index]<-1*wScreen/200){
        bls[index]=false;
        return false;
    }
    return true;
}

int screenSize::getYBoll(int index)
{
    return blsY[--index];
}

int screenSize::getXBoll(int index)
{
    return blsX[--index];
}

void screenSize::clearBoll(int index)
{
    bls[--index]=false;
}

int screenSize::getIndex()
{
    return mapPoint;
}

