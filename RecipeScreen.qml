import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import Recipe.Models 1.0

Item {
    Rectangle {
        anchors.fill: parent
        color: "#FAF0DC" // lub inny kolor tła, np. "#ffffff"
        z: 0 // tło musi być pod innymi elementami
    }

    ColumnLayout {
        spacing: 20
        anchors.top: parent.top
        anchors.bottom: parent.bottom

        anchors.right: parent.right
        anchors.left: parent.left
        anchors.leftMargin: 10
        anchors.rightMargin: 10
        width: parent.width
        anchors.topMargin: 60

    Text{
        text: "My Recipes"
        color: "#3A3B3C"
        font.pixelSize : 30
        Layout.topMargin: 10
        horizontalAlignment: Text.AlignHCenter
        width: parent.width
        anchors.horizontalCenter: parent.horizontalCenter
        Layout.bottomMargin: -5
    }
    Rectangle {
        width: parent.width
        height: 4
        radius:50
        color: "#EED0B6"
    }

    ListView {
        //anchors.fill: parent
        Layout.fillWidth: true
        Layout.fillHeight: true
        clip: true
        model: RecipeModel

        delegate: Item {
            width: parent.width
            height: 50

            Column {
                spacing: 6
                anchors.fill: parent

                RowLayout{
                    spacing: 10
                    Layout.fillWidth: true

                    Text {
                        text: name
                        color:"#3A3B3C"
                        font.pixelSize : 22
                        font.bold: true
                        Layout.alignment: Qt.AlignLeft
                        Layout.preferredWidth: 200
                        elide: Text.ElideRight

                    }

                    Item {
                        Layout.fillWidth: true
                    }

                    Text {
                        text: description
                        color:"#3A3B3C"
                        font.pixelSize : 22
                        Layout.alignment: Qt.AlignRight
                        horizontalAlignment: Text.AlignRight
                        Layout.preferredWidth: 120
                    }
                }

                Repeater {
                   model: ingredients.length

                   Row {
                       spacing: 6
                       Text {
                           text: ingredients[index] + ":"
                           color:"#3A3B3C"
                       }
                       Text {
                           text: quantity[index]
                           color:"#3A3B3C"
                       }
                   }
               }

                Row {
                    spacing:4

                    Repeater{
                        model: 50

                        Rectangle{
                            width : 4
                            height:3
                            color: "#EED0B6"
                        }


                    }
                }
            }
        }
    }

        Button {
            text: "<font color=\"#3A3B3C\"> Go Back</font>"
            font.pixelSize : 26
            background: Rectangle {
            color: "white"
            border.color: "#EED0B6"
            border.width: 3
            radius: 5
            opacity: 1.0
            }
            width : 140
            height :35
            anchors.left: parent.left
            anchors.bottom: parent.bottom
            anchors.margins: 16

            onClicked: stackView.pop()

        }
    }
    Button {
        text: "<font color=\"#3A3B3C\">+</font>"
        font.pixelSize : 26
        background: Rectangle {
        color: "white"
        border.color: "#EED0B6"
        border.width: 3
        radius: 5
        opacity: 1.0
}
        width : 40
        height : 40
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        anchors.rightMargin: 27
        anchors.margins: 16
        onClicked: stackView.push("AddNewRecipeScreen.qml")

}
}
