import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

Item {
    Rectangle {
            anchors.fill: parent
            color: "#FAF0DC"
            z:0
        }
    Page{
        visible:true
        title: "Not enough products"
        height:300
        width:300

        Rectangle {
                anchors.fill: parent
                color: "#FAF0DC"
                z: 0
            }

        ColumnLayout {
            anchors.centerIn: parent
            spacing: 10
            width: parent.width * 0.8
            height:50

            Text {
                text: "You have not enough items in your fridge!"
            }
            Text {
                text: "Try adding them to shopping list instead!"
            }
            Button {
                text: "<font color=\"#3A3B3C\">Go back</font>"
                font.pixelSize : 26
                background: Rectangle {
                color: "white"
                border.color: "#EED0B6"
                border.width: 3
                radius: 5
                opacity: 1.0
        }
                width : 100
                height : 40
                anchors.left: parent.left
                anchors.margins: 25
                onClicked: {
                    stackView.pop()
                }
            }
        }
    }
}
