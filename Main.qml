import QtQuick
import QtQuick.Controls

ApplicationWindow {
    visible: true
    width: 1080
    height: 1920
    title: qsTr("Hello World")

    StackView {
        id: stackView
        anchors.fill: parent
        initialItem: MainScreen {}
    }
}
