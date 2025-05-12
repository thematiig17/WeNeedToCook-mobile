import QtQuick 2.15
import QtQuick.Controls 2.15

Window {
    width: 1080
    height: 1920
    visible: true
    title: qsTr("Hello World")

    StackView {
        id: stackView
        anchors.fill: parent

        Component.onCompleted: {
            const component = Qt.createComponent("MainScreen.qml")
            if (component.status === Component.Ready) {
                const obj = component.createObject(stackView, {
                    stackView: stackView
                })
                if (obj) {
                    stackView.push(obj)
                } else {
                    console.error("Nie udało się utworzyć instancji MainScreen")
                }
            } else {
                console.error("Błąd ładowania MainScreen:", component.errorString())
            }
        }
    }
}
