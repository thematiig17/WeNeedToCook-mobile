import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import Recipe.Models 1.0
Item {
    Page {
        title: "Add productas"

        ColumnLayout {
            anchors.centerIn: parent
            spacing: 10
            width: parent.width * 0.8

            TextField {
                id: nameField
                placeholderText: "Namer"
            }


            SpinBox {
                id: countField
                from: 0
                to: 999
                value: 1
            }

            ComboBox {
                id: unitSelector
                model: ["g", "ml", "pcs"]
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
            Button {
                text: "Add"
                onClicked: {
                    RecipeModel.addItemToFile(nameField.text, countField.value, unitSelector.currentText,noteArea.text)
                    RecipeModel.loadItemsFromFile()
                    stackView.pop() // wróć do listy
                }
            }

            Button {
                text: "Cancel"
                onClicked: {
                    RecipeModel.loadItemsFromFile()
                    stackView.pop()
                }
            }
        }
    }
}
