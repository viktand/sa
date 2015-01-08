#ifndef SCREENSIZE_H
#define SCREENSIZE_H

#include <QObject>

class screenSize : public QObject
{
    Q_OBJECT

public:
    screenSize(QObject *parent = 0);
    ~screenSize();

    Q_INVOKABLE int     screenWidth();                          // ширина экрана
    Q_INVOKABLE int     screenHeight();                         // высота экрана
    Q_INVOKABLE bool    imposition(int p1, int p1x, int p1y,
                                   double k1,
                                   int p2, int p2x, int p2y,
                                   double k2);                  // расчитать пересечение двух полигонов
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
    Q_INVOKABLE void loadMap(int index);                        // загрузить карту уровня index
    Q_INVOKABLE double getPoint();                              // получить очередную точку из карты

private:
    QPoint pointFromStr(QString st);                            // получить точку из строки "x,y"
    void    loadObj();                              // загрузить из ресурсов полигоны объектов
};

#endif // SCREENSIZE_H



