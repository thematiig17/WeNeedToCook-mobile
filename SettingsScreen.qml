import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import DebugMode
import UserVariables

Item {
    Rectangle{
        anchors.fill: parent
        z:0
        color:"#FAF0DC"
    }

    ColumnLayout {
        spacing: 15
        Layout.topMargin: 40
        width: parent.width
        Layout.alignment: Qt.AlignCenter

        Text{
            Layout.topMargin: 150
            text: "Settings"
            color: "black"
            font.pixelSize : 30
            horizontalAlignment: Text.AlignHCenter
            anchors.horizontalCenter: parent.horizontalCenter
            width: parent.width - 60
            Layout.bottomMargin: -5
            anchors.margins: 16
        }
        Rectangle{
            color:"#EED0B6"
            width: parent.width - 60
            Layout.alignment: Qt.AlignCenter
            height: 3
        }
        CheckBox {
            id: debugModeEnabled
            anchors.horizontalCenter: parent.horizontalCenter
            text: qsTr("Debug mode")
            checked: DebugMode.debugModeStatus()
        }

        Text{
            text: "Enter your name: "
            color: "black"
            horizontalAlignment: Text.AlignHCenter
            anchors.horizontalCenter: parent.horizontalCenter

        }
        TextField {
            id: nameOfUser
            height:30
            horizontalAlignment: Text.AlignHCenter
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.margins: 5
            text: UserVariables.getNameOfUser()
        }
    }
    Button {
        text: "<font color=\"#3A3B3C\"> Go Back</font>"
        font.pixelSize : 26
        background: Rectangle {
            color: "white"
            border.color: "#EED0B6"
            border.width: 3
            radius: 7
            opacity: 1.0
        }
        width : 140
        height :35
        anchors.left: parent.left
        anchors.bottom: parent.bottom
        anchors.margins: 20
        onClicked: {
            if (debugModeEnabled.checked) {
                DebugMode.enableDebugMode()
                console.log("enabled Debug Mode (qml)")
                console.log(DebugMode.isDebugModeEnabled)
            } else {
                DebugMode.disableDebugMode()
                console.log("disabled Debug Mode (qml)")
                console.log(DebugMode.debugModeStatus)
            }
            UserVariables.changeNameOfUser(nameOfUser.text)

            var view = parent
            while (view && !view.pop) view = view.parent

            if (view) {
                view.pop()
            }
        }
    }
}
