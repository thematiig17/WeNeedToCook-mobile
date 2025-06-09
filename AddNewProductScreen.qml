import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import App.Models 1.0
Item {
    Page {
        visible:true
        title: "Add new product"
        height:300
        width:300

        ColumnLayout {
            anchors.centerIn: parent
            spacing: 10
            width: parent.width * 0.8
            height:50

            Text{
                text:"Add new product"
                font.bold:true
                font.pointSize: 33
                   }

            Row {
                spacing:10

                Text{
                text:"Name:"
                anchors.verticalCenter: parent.verticalCenter
                width: 60
                height:20
                }

                TextField {
                id: nameField
                anchors.verticalCenter: parent.verticalCenter
                height:30

            }
            }
            Row{
                spacing:10
                Text{
                text:"Amount:";width: 60
                }
            TextField {
                id: amountField
                width: 80
                height:30
                inputMethodHints: Qt.ImhFormattedNumbersOnly

            }
            }
            Row{
                spacing:-5

            Text{
                text:"Unit:"
                width: 60

                }
            ComboBox {
                id: unitSelector
                width:90
                height:30
                model: ["g", "ml", "pcs"]
            }
            }
            Row{

            Rectangle{
                    width:350
                    height: 200
                    border.color: "gray"
                    border.width:1
                    radius:5


                TextArea{
                id:noteArea
                width:350
                height: 200
                anchors.fill:parent
                anchors.margins:5
                placeholderText:"Enter note..."
                wrapMode: TextArea.Wrap
                }
                }

            }
        Row{

            Button {
                text: "<font color=\"#FFFFFF\">Cancel</font>"
                font.pixelSize : 26
                background: Rectangle {
                color: "SteelBlue"
                radius: 20
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
                text: "<font color=\"#FFFFFF\">Add</font>"
                font.pixelSize : 26
                background: Rectangle {
                color: "SteelBlue"
                radius: 20
                opacity: 1.0
        }
                width : 80
                height : 40
                anchors.right: parent.right
                anchors.margins: -300
                onClicked: {
                    FridgeModel.addItemToFile(nameField.text, amountField.text, unitSelector.currentText)
                    FridgeModel.loadItemsFromFile()
                    stackView.pop() // wróć do listy
                }
            }
        }
    }

}
}
