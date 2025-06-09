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

            Button {
                text: "Add"
                onClicked: {
                    RecipeModel.addItemToFile(nameField.text, countField.value, unitSelector.currentText)
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
