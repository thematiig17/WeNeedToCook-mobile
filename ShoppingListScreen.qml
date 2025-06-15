import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import ShoppingList.Models 1.0

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
        text: "Shopping list"
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
        model: ShoppingListModel


        delegate: Item {
            width: parent.width
            height: 50 +(showNote ? noteText.implicitHeight + 50 :0)
            property bool showNote: false

            MouseArea {
                   id: clickArea
                   width: parent.width
                   height: 50
                   onClicked: showNote = !showNote

            Column {
                spacing: 6
                anchors.fill: parent

                RowLayout{
                    spacing: 10
                    Layout.fillWidth: true

                    Text {
                        text: name
                        color: "#3A3B3C"
                        font.pixelSize : 22
                        font.bold: true
                        Layout.alignment: Qt.AlignLeft
                        Layout.preferredWidth: 200
                        elide: Text.ElideRight

                    }
                    Item { width: 1; height: 24 }

                                Item { Layout.fillWidth: true }


                    Text {
                        //text: count + unit
                        text: {
                                if (unit === "ml" && count > 1000) {
                                    return (count / 1000) + "L";
                                } else if (unit === "g" && count >= 1000) {
                                    return (count / 1000) + "kg";
                                } else {
                                    return count + unit;
                                }
                            }
                        color:"#3A3B3C"
                        font.pixelSize : 22
                        Layout.alignment: Qt.AlignRight
                        horizontalAlignment: Text.AlignRight
                        Layout.preferredWidth: 120
                    }
                }
                                        Item{

                                        width: parent.width
                                        visible: showNote
                                        height: showNote ? noteText.implicitHeight + 50 : 0
                                        Behavior on height { NumberAnimation { duration: 200 } }

                                        Text {
                                            id: noteText
                                            anchors.fill: parent
                                            anchors.margins: 10
                                            text: note
                                            wrapMode: Text.Wrap
                                            font.pixelSize: 18
                                            color: "#3A3B3C"
                                            visible: parent.visible
                                        }

                                        Row{
                                        spacing:245
                                        anchors.left: parent.left
                                        anchors.bottom:parent.bottom

                                        Button{
                                            text: "<font color=\"#3A3B3C\">Delete</font>"
                                            background: Rectangle {
                                            color: "#EA917E"
                                            border.color: "#DA5033"
                                            border.width:3
                                            radius: 5
                                            opacity: 1.0
                                        }
                                            width : 60
                                            height :30
                                            onClicked: {
                                                FileIO.deleteByName("ShoppingListData", name)
                                                stackView.pop()
                                                ShoppingListModel.loadItemsFromFile()
                                                stackView.push("ShoppingListScreen.qml")
                                            }






                                        }
                                        // trzeba zrobic zeby nadpisywalo informacje lub usuwalo xddd i wpisywalo nowe
                                        Button{
                                            text: "<font color=\"#3A3B3C\">Edit</font>"
                                            background: Rectangle {
                                            color: "#76C2E9"
                                            border.color:"SteelBlue"
                                            border.width: 3
                                            radius: 5
                                            opacity: 1.0
                                        }
                                            width : 60
                                            height :30
                                            onClicked: {
                                                console.log("DANE PRZEKAZYWANE:", name, count, unit, note)
                                                stackView.push("EditShoppingListScreen.qml", {"passedName": name, "passedValue": count, "passedUnit": unit, "passedNote": note})
                                            }




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
            }}

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
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        anchors.margins: 16
        anchors.rightMargin: 27

        onClicked: stackView.push("AddNewToShoppingList.qml")

}
}
