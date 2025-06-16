import QtQuick
import QtQuick.Controls
import App.Models 1.0
import Recipe.Models 1.0
import ShoppingList.Models 1.0

ApplicationWindow {
    visible: true
    width: 1080
    height: 1920
    title: qsTr("Hello World")
    StackView{
        id: stackView
        anchors.fill: parent
        initialItem: MainScreen {}
    }
}
