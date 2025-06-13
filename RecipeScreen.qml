import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import Recipe.Models 1.0

Item {

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
        color: "black"
        font.pixelSize : 30
        Layout.topMargin: 10
        horizontalAlignment: Text.AlignHCenter
        width: parent.width
        anchors.horizontalCenter: parent.horizontalCenter
        Layout.bottomMargin: -5
    }

    ListView {
        //anchors.fill: parent
        Layout.fillWidth: true
        Layout.fillHeight: true
        clip: true
        model: RecipeModel

        header: Rectangle {
            width: parent.width
            height: 1
            color: "black"
        }

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
                       }
                       Text {
                           text: quantity[index]
                       }
                   }
               }

                Row {
                    spacing:4

                    Repeater{
                        model: 50

                        Rectangle{
                            width : 4
                            height:2
                            color: "black"
                        }


                    }
                }
            }
        }
    }

        Button {
            text: "<font color=\"#FFFFFF\"> Go Back</font>"
            font.pixelSize : 26
            background: Rectangle {
            color: "SteelBlue"
            radius: 20
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
        text: "<font color=\"#FFFFFF\">+</font>"
        font.pixelSize : 26
        background: Rectangle {
        color: "SteelBlue"
        radius: 20
        opacity: 1.0
}
        width : 40
        height : 40
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        anchors.margins: 16
        onClicked: stackView.push("AddNewRecipeScreen.qml")

}
}
