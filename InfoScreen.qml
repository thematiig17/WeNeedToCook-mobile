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
        spacing: 5
        anchors.horizontalCenter: parent.horizontalCenter

        Text{
            Layout.topMargin: parent.height * 0.15
            text: "About our app"
            color: "#3A3B3C"
            font.pixelSize : 30
            horizontalAlignment: Text.AlignHCenter
            anchors.horizontalCenter: parent.horizontalCenter
            Layout.bottomMargin: parent.height * -0.04
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
            Layout.topMargin: parent.height * -0.1
            anchors.horizontalCenter: parent.horizontalCenter
            Layout.preferredHeight: parent.height * 0.5
            Layout.preferredWidth: parent.width * 0.8
            color: "white"
            border.width: 3
            border.color: "#EED0B6"
            radius: 25
            Text{
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.centerIn: parent
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                text: "Welcome to WeNeedToCook! Your all-in-one kitchen companion! Whether you're planning meals, managing groceries, or just trying to keep track of what's in your fridge, we've got you covered. No more forgotten ingredients or wasted food – just a simpler, smarter way to run your kitchen."
                wrapMode: Text.WordWrap
                width: parent.width * 0.9
                font.pointSize: 21
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
