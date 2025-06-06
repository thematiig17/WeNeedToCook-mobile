#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include "ItemsInFridgeData.h"
#include "FileIO.h"

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);

    QQmlApplicationEngine engine;
    QObject::connect(
        &engine,
        &QQmlApplicationEngine::objectCreationFailed,
        &app,
        []() { QCoreApplication::exit(-1); },
        Qt::QueuedConnection);

    static ItemsInFridgeModel fridgeModel;
    qmlRegisterSingletonInstance("App.Models", 1, 0, "FridgeModel", &fridgeModel);
    FileIO fileIO;
    engine.rootContext()->setContextProperty("FileIO", &fileIO);


    engine.loadFromModule("WeNeedToCook-mobile", "Main");

    return app.exec();
}
