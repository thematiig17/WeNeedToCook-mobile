import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import DebugMode
import UserVariables

Item {
    ColumnLayout {
        anchors.centerIn: parent
        spacing: 10
        width: parent.width * 0.8
        height:50
        Button {
            text: "Wróć"
            anchors.centerIn: parent
            onClicked: {
                if (debugModeEnabled.checked) {
                    //DebugMode.isDebugModeEnabled = true
                    DebugMode.enableDebugMode()
                    console.log("enabled Debug Mode (qml)")
                    console.log(DebugMode.isDebugModeEnabled)
                } else {
                    //DebugMode.isDebugModeEnabled = false
                    DebugMode.disableDebugMode()
                    console.log("disabled Debug Mode (qml)")
                    console.log(DebugMode.debugModeStatus)
                }

                //trzeba bedzie zrobic zabezpieczenie wprowadzenia nazwy uzytkownika

                UserVariables.changeNameOfUser(nameOfUser.text)

                var view = parent
                while (view && !view.pop) view = view.parent

                if (view) {
                    // Odśwież tekst w poprzednim widoku
                    var previousItem = view.currentItem
                    if (previousItem && previousItem.refresh) {
                        previousItem.refresh()
                    }
                    view.pop()
                }
            }
        }
        CheckBox {
            id: debugModeEnabled
            text: qsTr("Debug mode")
            checked: DebugMode.debugModeStatus()
        }
        TextField {
        id: nameOfUser
        anchors.verticalCenter: parent.verticalCenter
        height:30
        text: UserVariables.getNameOfUser()
        }
    }


}
