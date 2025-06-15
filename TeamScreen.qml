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
        anchors.fill: parent
        spacing: 10
        anchors.horizontalCenter: parent.horizontalCenter

        Text{
            Layout.topMargin: parent.height * 0.24
            Layout.bottomMargin: parent.height * -0.02
            text: "Our Team"
            color: "#3A3B3C"
            font.pixelSize : 30
            horizontalAlignment: Text.AlignHCenter
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.margins: 16
        }
        Rectangle {
            color:"#EED0B6"
            width: parent.width * 0.9
            anchors.horizontalCenter: parent.horizontalCenter
            height: 3
            radius: 50
        }

        Rectangle {
            anchors.horizontalCenter: parent.horizontalCenter
            height: parent.height * 0.25
            width: parent.width * 0.8
            Layout.bottomMargin: 300
            color: "white"
            border.width: 3
            border.color: "#EED0B6"
            radius: 25
            Text{
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.centerIn: parent
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                text: "Mateusz Grabowski gr 1.2 Klaudia Chołda gr 4.8 Piotr Ptak gr 1.2"
                wrapMode: Text.WordWrap
                width: parent.width * 0.9
                font.pointSize: 23
                font.bold: true
                color: "#3A3B3C"
            }
        }
    }

         Button {
            text: "<font color=\"#3A3B3C\"> Go Back</font>"
            font.pixelSize : 26
            width : parent.width * 0.35
            height :parent.height * 0.05
            anchors.left: parent.left
            anchors.bottom: parent.bottom
            anchors.margins: 20
            background: Rectangle {
                color: "SteelBlue"
                radius: 20
                opacity: 1.0
            }
            onClicked: {
                stackView.push("MainScreen.qml")
            }
        }

}
