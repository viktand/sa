#include "screensize.h"
#include <QApplication>
#include "QDesktopWidget"
#include <math.h>
#include <QVector>
#include <QFile>
#include <QDebug>


struct trian{
    QPoint v1;
    QPoint v2;
    QPoint v3;
};
int plg=0;  // количество загруженных полигонов
std::vector<std::vector<trian> >objts; // массив объектов
int rn=0;   // переменная для увеличения разброса генератора случайных чисел
bool bls[10]={false,false,false,false,false,false,false,false,false,false}; // массив летящих ядер
int blsX[10]={0,0,0,0,0,0,0,0,0,0}; // X
int blsY[10]={0,0,0,0,0,0,0,0,0,0}; // Y
double blsF[10]={0,0,0,0,0,0,0,0,0,0}; // сила, с которой летит ядро (или скорость, если так понятнее) (+)вверх, (-)вниз
int wScreen,hScreen;        // размеры экрана

screenSize::screenSize(QObject *parent) : QObject(parent){
    loadObj();
    wScreen=screenWidth();
    hScreen=screenHeight();
}

screenSize::~screenSize(){}

int screenSize::screenWidth(){return QApplication::desktop()->width();}

int screenSize::screenHeight(){return QApplication::desktop()->height();}

void screenSize::loadObj()
{
    QFile boss(":/poligons/plgs");
    QString ln;
    QByteArray line;
    QPoint cen,v3,v2;
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
                      while (!ob.atEnd()) {
                         line=ob.readLine();
                         ln=QString::fromLatin1(line).trimmed();
                         if(ln.left(1)!="#"){ // это не комментарий - обрабатываем
                             switch (fase) {
                             case 0:
                                 cen=pointFromStr(ln);
                                 fase++;
                                 break;
                             case 1:
                                 v2=pointFromStr(ln);
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
                  }
              }

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
    switch (pol) {
    case 0:
        return "qrc:/images/ship";
        break;
       case 1:
        return "qrc:/images/stn";
        break;
    case 2:
        return "qrc:/images/stn2";
        break;
    case 3:
        return "qrc:/images/stn3";
        break;
    case 4:
        return "qrc:/images/stn4";
        break;
    case 5:
        return "qrc:/images/stn5";
        break;
    case 6:
        return "qrc:/images/dot1";
        break;
    case 7:
        return "qrc:/images/boll";
        break;
    case 8:
        return "qrc:/images/rock1";
        break;
    case 9:
        return "qrc:/images/dot1boom";
        break;
    case 10:
        return "qrc:/images/bonusmiss";
        break;
    default:
        return "qrc:/images/stn";
        break;
    }
        return "qrc:/images/stn";
}

int screenSize::getPoligonWidth(int pol)
{
    int r=0;
    for(int i=0;i<int(objts[pol].size());i++){
        if(objts[pol][i].v2.x()>r)r=objts[pol][i].v2.x();
    }
    return r;
}

int screenSize::shootBoll(int x, int y, int f) // регистрация ядер
{
    for(int i=0;i<10;i++){
        if(!bls[i]){
            bls[i]=true;
            blsX[i]=x;
            blsY[i]=y;
            blsF[i]=f;
            return i+1;
        }
    }
    return 0;
}

bool screenSize::getXYBoll(int index) // вычислить очередные координаты ядра
// если ядро улетело с экрана, то освободить место в массиве и послать false,
// если ядро еще на экране, то вернуть true
{
    blsX[--index]-=wScreen/100;
    if(blsF[index]!=0)blsY[index]-=blsF[index];
    blsF[index]-=double(hScreen)/20000.0; //высота вылета ядра. Чем больше делитель, тем выше
    if(blsX[index]<-1*wScreen/100){
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
