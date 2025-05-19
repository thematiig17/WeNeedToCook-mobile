#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include "ItemsInFridgeData.h"

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

    ItemsInFridgeModel fridgeModel;
    engine.rootContext()->setContextProperty("itemsInFridgeModel", &fridgeModel);


    engine.loadFromModule("WeNeedToCook-mobile", "Main");

    return app.exec();
}
