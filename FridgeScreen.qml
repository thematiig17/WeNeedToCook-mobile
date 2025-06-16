import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import App.Models 1.0
import DebugMode

Page {
    Rectangle{
        anchors.fill: parent
        z:0
        color:"#FAF0DC"
    }
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
            color: "#3A3B3C"
            font.pixelSize : 30
            Layout.topMargin: 10
            horizontalAlignment: Text.AlignHCenter
            width: parent.width
            anchors.horizontalCenter: parent.horizontalCenter
            Layout.bottomMargin: -5
        }

        //DEBUG BUTTONS
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

        Rectangle {
            width: parent.width
            height: 4
            radius:50
            color: "#EED0B6"
        }

        ListView {
            width: parent.width
            Layout.fillWidth: true
            Layout.fillHeight: true
            clip: true
            model: FridgeModel

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
                                    text: { //odpowiednia jednostka
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
                                        // strona sie nie reloaduje sama, moze to nie jakos turbo wazne ale jak ktos ma czas moze zrobic xD
                                        onClicked: {
                                            FileIO.deleteByName("FridgeData", name)
                                            stackView.pop()
                                            FridgeModel.loadItemsFromFile()
                                            stackView.push("FridgeScreen.qml")
                                        }
                                    }
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
                                            stackView.push("EditProductScreen.qml", {"passedName": name, "passedValue": count, "passedUnit": unit, "passedNote": note})
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
                        }
                    }
                }
            }
            Button {
                text: "<font color=\"#3A3B3C\"> Go Back</font>"
                font.pixelSize : 26
                background: Rectangle {
                    color: "white"
                    border.color:"#EED0B6"
                    border.width: 3
                    radius: 5
                    opacity: 1.0
                }
                width : 140
                height :35
                anchors.left: parent.left
                anchors.bottom: parent.bottom
                anchors.margins: 20
                onClicked: stackView.pop()
            }
        }
        Button {
            text: "<font color=\"#3A3B3C\">+</font>"
            font.pixelSize : 26
            background: Rectangle {
                color: "white"
                border.color:"#EED0B6"
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
            onClicked: stackView.push("AddNewProductScreen.qml")
        }
    }
