cmake_minimum_required(VERSION 3.16)

project(WeNeedToCook-mobile VERSION 0.1 LANGUAGES CXX)

set(CMAKE_CXX_STANDARD_REQUIRED ON)

find_package(Qt6 REQUIRED COMPONENTS Quick)

qt_standard_project_setup(REQUIRES 6.8)

qt_add_executable(appWeNeedToCook-mobile
    main.cpp
)

qt_add_qml_module(appWeNeedToCook-mobile
    URI WeNeedToCook-mobile
    VERSION 1.0
    QML_FILES
        Main.qml
        MainScreen.qml
        SettingsScreen.qml
        FridgeScreen.qml
        AddNewProductScreen.qml
        RecipeScreen.qml
        AddNewRecipeScreen.qml
        ShoppingListScreen.qml
        AddNewToShoppingList.qml
    SOURCES
        ItemsInFridgeData.h ItemsInFridgeData.cpp
        FileIO.h FileIO.cpp
        RecipeBookData.h
        RecpieBookData.cpp
        DebugModeHandle.h DebugModeHandle.cpp
        UserVariables.h UserVariables.cpp
        ShoppingList.h
        ShoppingListData.cpp
        QML_FILES InfoScreen.qml
        QML_FILES TeamScreen.qml
        QML_FILES EditProductScreen.qml
        QML_FILES EditShoppingListScreen.qml
        QML_FILES EditRecipeScreen.qml
        QML_FILES NotEnoughItems.qml

)

# Qt for iOS sets MACOSX_BUNDLE_GUI_IDENTIFIER automatically since Qt 6.1.
# If you are developing for iOS or macOS you should consider setting an
# explicit, fixed bundle identifier manually though.
set_target_properties(appWeNeedToCook-mobile PROPERTIES
#    MACOSX_BUNDLE_GUI_IDENTIFIER com.example.appWeNeedToCook-mobile
    MACOSX_BUNDLE_BUNDLE_VERSION ${PROJECT_VERSION}
    MACOSX_BUNDLE_SHORT_VERSION_STRING ${PROJECT_VERSION_MAJOR}.${PROJECT_VERSION_MINOR}
    MACOSX_BUNDLE TRUE
    WIN32_EXECUTABLE TRUE
)

target_link_libraries(appWeNeedToCook-mobile
    PRIVATE Qt6::Quick
)

include(GNUInstallDirs)
install(TARGETS appWeNeedToCook-mobile
    BUNDLE DESTINATION .
    LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
    RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}
)
