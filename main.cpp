#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include "ItemsInFridgeData.h"
#include "FileIO.h"
#include "RecipeBookData.h"
#include "DebugModeHandle.h"

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
    static RecipeBookModel recipeModel;
    qmlRegisterSingletonInstance("Recipe.Models", 1, 0, "RecipeModel", &recipeModel);
    FileIO fileIO;
    engine.rootContext()->setContextProperty("FileIO", &fileIO);
    static DebugModeHandle debugModeHandle;
    qmlRegisterSingletonInstance("DebugMode", 1, 0, "DebugMode", &debugModeHandle);


    engine.loadFromModule("WeNeedToCook-mobile", "Main");

    return app.exec();
}
