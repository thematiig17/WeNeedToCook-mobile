#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include "ItemsInFridgeData.h"
#include "FileIO.h"
#include "RecipeBookData.h"
#include "ShoppingList.h"
#include "DebugModeHandle.h"
#include "UserVariables.h"

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
    static ShoppingListModel shoppinglistModel;
    qmlRegisterSingletonInstance("ShoppingList.Models", 1, 0, "ShoppingListModel", &shoppinglistModel);
    FileIO fileIO;
    engine.rootContext()->setContextProperty("FileIO", &fileIO);
    static DebugModeHandle debugModeHandle;
    qmlRegisterSingletonInstance("DebugMode", 1, 0, "DebugMode", &debugModeHandle);
    static UserVariables userVariables;
    qmlRegisterSingletonInstance("UserVariables", 1, 0, "UserVariables", &userVariables);


    engine.loadFromModule("WeNeedToCook-mobile", "Main");

    return app.exec();
}
