#include <QApplication>
#include <QQmlComponent>
#include <QQmlApplicationEngine>

#include "screensize.h"

int main(int argc, char *argv[])
{
    QApplication app(argc, argv);
    qmlRegisterType<screenSize>("screenSize",1,0,"ScreenFunctions");     //регистрация класса

    QQmlApplicationEngine engine;
    engine.load(QUrl(QStringLiteral("qrc:/main.qml")));

    return app.exec();
}

