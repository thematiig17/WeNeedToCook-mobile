import QtQuick 2.15
import QtQuick.Controls 2.15

Item {
    property StackView stackView
    Button {
        text: "Idź do ustawień"
        font.pointSize: 18
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 40
        anchors.left: parent.left
        anchors.leftMargin: 20
        anchors.right: parent.right
        anchors.rightMargin: 20
        height: 60
        onClicked: {

            /*PRZECHODZENIE POMIĘDZY EKRANAMI*/
            const component = Qt.createComponent("SettingsScreen.qml")
            if (component.status === Component.Ready) {
                const obj = component.createObject(stackView, {
                    stackView: stackView
                })
                if (obj) {
                    stackView.push(obj)
                } else {
                    console.error("Nie udało się utworzyć instancji SettingsScreen")
                }
            } else {
                console.error("Błąd ładowania SettingsScreen:", component.errorString())
            }
        }
    }
}

