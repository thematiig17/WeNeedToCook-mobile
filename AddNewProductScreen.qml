import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import App.Models 1.0
Item {
    Page {
        title: "Add product"

        ColumnLayout {
            anchors.centerIn: parent
            spacing: 10
            width: parent.width * 0.8

            TextField {
                id: nameField
                placeholderText: "Name"
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
                    FridgeModel.addItemToFile(nameField.text, countField.value, unitSelector.currentText)
                    FridgeModel.loadItemsFromFile()
                    stackView.pop() // wróć do listy
                }
            }

            Button {
                text: "Cancel"
                onClicked: {
                    FridgeModel.loadItemsFromFile()
                    stackView.pop()
                }
            }
        }
    }
}
