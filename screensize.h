#ifndef SCREENSIZE_H
#define SCREENSIZE_H

#include <QObject>

class screenSize : public QObject
{
    Q_OBJECT

//    struct livel{  // единица описания уровня
//        int    time;
//        int    type;
//        double x;
//        double y;
//    };

public:
    screenSize(QObject *parent = 0);
    ~screenSize();

    Q_INVOKABLE int     screenWidth();                          // ширина экрана
    Q_INVOKABLE int     screenHeight();                         // высота экрана
    Q_INVOKABLE bool    imposition(int p1, int p1x, int p1y,
                                   double k1,
                                   int p2, int p2x, int p2y,
                                   double k2);                  // расчитать пересечение двух полигонов
    Q_INVOKABLE bool    toImpos(int p1, int p1x, int p1y,
                                double k1, int index);          // проверить пересечение спрайта index и полигона
    Q_INVOKABLE int     getRND(int h);                          // случайное число от 0 до h
    /* p1 - номер полигона
     * px1,py1 - координаты полигона
     * k1 - масштаб полигона
     */
    Q_INVOKABLE QString getImage(int pol);                      // получить имя картинки по номеру полигона
    Q_INVOKABLE int getPoligonWidth(int pol);                   // получить ширину полигона
    Q_INVOKABLE int shootBoll(int x, int y, int f);             // выстрел ядром из указанных координат с силой f
    Q_INVOKABLE bool getXYBoll(int index);                      // пересчитать координаты ядра index. false - снять ядро
    Q_INVOKABLE int getXBoll(int index);                        // узнать координату ядра index
    Q_INVOKABLE int getYBoll(int index);                        // узнать координату ядра index
    Q_INVOKABLE void clearBoll(int index);                      // снять ядро index
    Q_INVOKABLE int getIndex();                                 // получить текущий индекс карты (для отладки)
    Q_INVOKABLE void loadLivel(int index);                      // загрузить уровень index
    Q_INVOKABLE void setObj(int time, int tsheft);              // установить объекты указанной точки времени
    Q_INVOKABLE void chPoligon(int index);                      // переключить полигон
    Q_INVOKABLE void incTime();                                 // инкремент счетчика времени
    Q_INVOKABLE int getWithSheep(int i);                        // реакция на столкновение с кораблем
    Q_INVOKABLE int action2(int index, int x, int y);           // действие объекта
    Q_INVOKABLE int getSecondPiligon(int i);                    // получить второй полигон для объета типа i
    Q_INVOKABLE bool actPoint(int index, int p);                // узнать соответствие точки времени точке активности для объекта
    Q_INVOKABLE int getSpeedKf();                               // получить значение коэфф. скорости для этого экрана

signals:
    void killSprite(int index);                                 // убрать объект index
    void drawSprite(int i,int x,int y, int w, int h,
                    QString p, bool l, int v,
                    int pl, double k);                          // включить спрайт
    void info (QString st);                                     // показать сообщение

private:
    QPoint pointFromStr(QString st);                            // получить точку из строки "x,y"
    void    loadObj();                                          // загрузить из ресурсов полигоны объектов
    void    loadObj2();                                         // загрузить из ресурсов объекты



};


#endif // SCREENSIZE_H



