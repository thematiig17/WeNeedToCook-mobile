import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import App.Models 1.0
import DebugMode

Item {
    Component.onCompleted: {
        if (DebugMode.debugModeStatus() === true){
            debugButtons.visible = true
            console.log("debug mode: true")
        } else {
            debugButtons.visible = false
            console.log("debug mode: false")
        }
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
        text: "My Fridge"
        color: "black"
        font.pixelSize : 30
        Layout.topMargin: 10
        horizontalAlignment: Text.AlignHCenter
        width: parent.width
        anchors.horizontalCenter: parent.horizontalCenter
        Layout.bottomMargin: -5
    }

    //TEST DO USUNIECIA POTEM
    RowLayout {
        spacing: 20
        id: debugButtons
        Button {
            text: "Dodaj testowe dane"
            onClicked: {
                FileIO.createExampleJson("FridgeData")
                stackView.pop()
                FridgeModel.loadItemsFromFile()
                stackView.push("FridgeScreen.qml")
            }
        }
        Button {
            text: "Usun wszystkie dane"
            onClicked: {
                FileIO.deleteJson("FridgeData")
                stackView.pop()
                FridgeModel.loadItemsFromFile()
                stackView.push("FridgeScreen.qml")
            }
        }
    }


    //TEST DO USUNIECIA POTEM

    Text { text: "Model count: " + FridgeModel.count }

    ListView {
        //anchors.fill: parent
        Layout.fillWidth: true
        Layout.fillHeight: true
        clip: true
        model: FridgeModel

        header: Rectangle {
            width: parent.width
            height: 1
            color: "black"
        }

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
                        font.pixelSize : 22
                        Layout.alignment: Qt.AlignRight
                        horizontalAlignment: Text.AlignRight
                        Layout.preferredWidth: 120
                    }
                }
                Item {
                        width: parent.width
                        visible: showNote
                        height: showNote ? noteText.implicitHeight + 50 : 0 // padding
                        Behavior on height { NumberAnimation { duration: 200 } }

                        Text {
                            id: noteText
                            anchors.fill: parent
                            anchors.margins: 10
                            text: note
                            wrapMode: Text.Wrap
                            font.pixelSize: 18
                            color: "purple"
                            visible: parent.visible
                        }

                        Row{
                        spacing:245
                        anchors.left: parent.left
                        anchors.bottom:parent.bottom

                        Button{
                            text: "<font color=\"#FFFFFF\">Delete</font>"
                            background: Rectangle {
                            color: "Red"
                            radius: 5
                            opacity: 1.0
                        }
                            width : 60
                            height :30
                            // trzeba zmienic na dowolny item zeby nie usuwalo wszystkiego :(
                            onClicked: {
                                FileIO.deleteJson("FridgeData")
                                stackView.pop()
                                FridgeModel.loadItemsFromFile()
                                stackView.push("FridgeScreen.qml")
                            }




                        }
                        // trzeba zrobic zeby nadpisywalo informacje lub usuwalo xddd i wpisywalo nowe
                        Button{
                            text: "<font color=\"#FFFFFF\">Edit</font>"
                            background: Rectangle {
                            color: "SteelBlue"
                            radius: 5
                            opacity: 1.0
                        }
                            width : 60
                            height :30




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
            }}

        }

    }

        Button {
            text: "<font color=\"#FFFFFF\"> Go Back</font>"
            font.pixelSize : 22
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
        onClicked: stackView.push("AddNewProductScreen.qml")

}
}
