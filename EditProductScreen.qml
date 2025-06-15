import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import App.Models 1.0
Page {
    id: editPage
    property var passedName
    property var passedValue
    property var passedUnit
    property var passedNote

    visible: true
    title: "Edit existing product"
    height: 300
    width: 300


    Rectangle {
            anchors.fill: parent
            color: "#FAF0DC"
            z:0
        }


        ColumnLayout {
            anchors.centerIn: parent
            spacing: 10
            width: parent.width * 0.8
            height:50

            Text{
                text:"Edit existing product"
                color:"#3A3B3C"
                font.bold:true
                font.pointSize: 33
                   }

            Row {
                spacing:10

                Text{
                text:"Name:"
                color:"#3A3B3C"
                anchors.verticalCenter: parent.verticalCenter
                width: 60
                height:20
                }

                TextField {
                id: nameField
                anchors.verticalCenter: parent.verticalCenter
                text: passedName
                enabled: false
                width:150
                height:30
                background: Rectangle {
                            color: "white"
                            border.color: "#EED0B6"
                            border.width: 2
                            radius: 4
                        }

            }
            }
            Row{
                spacing:10
                Text{
                text:"Amount:"
                color:"#3A3B3C"
                width: 60
                }
            TextField {
                id: amountField
                text: passedValue
                width: 80
                height:30
                inputMethodHints: Qt.ImhFormattedNumbersOnly
                background: Rectangle {
                            color: "white"
                            border.color: "#EED0B6"
                            border.width: 2
                            radius: 4
                        }

            }
            }
            Row{
                spacing:-5

            Text{
                text:"Unit:"
                color:"#3A3B3C"
                width: 60

                }
            ComboBox {
                id: unitSelector
                width:90
                height:30
                model: ["g", "ml", "pcs"]
                Component.onCompleted: {
                        const index = unitSelector.find(passedUnit)
                        if (index >= 0)
                            unitSelector.currentIndex = index
                    }
                background: Rectangle {
                            color: "white"
                            border.color: "#EED0B6"
                            border.width: 2
                            radius: 4
                        }
            }
            }
            Row{

            Rectangle{
                    width:350
                    height: 200
                    border.color: "#3A3B3C"
                    border.width:1
                    radius:5


                TextArea{
                id:noteArea
                width:350
                height: 200
                anchors.fill:parent
                anchors.margins:0
                placeholderText:"Enter note..."
                text: passedNote
                wrapMode: TextArea.Wrap
                background: Rectangle {
                            color: "white"
                            border.color: "#EED0B6"
                            border.width: 2
                            radius: 4
                        }
                }
                }

            }
        Row{

            Button {
                text: "<font color=\"#3A3B3C\">Cancel</font>"
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
                    FridgeModel.loadItemsFromFile()
                    stackView.pop()
                }
            }
            Button {
                text: "<font color=\"#3A3B3C\">Add</font>"
                font.pixelSize : 26
                background: Rectangle {
                color: "white"
                border.color: "#EED0B6"
                border.width: 3
                radius: 5
                opacity: 1.0
        }
                width : 80
                height : 40
                anchors.right: parent.right
                anchors.margins: -300
                onClicked: {
                    FileIO.editExistingEntry("FridgeData", passedName, FileIO.makeJsonFromFridge(passedName, amountField.text, unitSelector.currentText, noteArea.text/*passedValue, passedUnit, passedNote*/))
                    FridgeModel.loadItemsFromFile()
                    stackView.pop() // wróć do listy
                }
            }
        }
    }

}
