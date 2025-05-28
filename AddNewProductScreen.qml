import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

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

            Button {
                text: "Add"
                onClicked: {
                    itemsInFridgeModel.addItemToFile(nameField.text, countField.value)
                    itemsInFridgeModel.loadItemsFromFile()
                    stackView.pop() // wróć do listy
                }
            }

            Button {
                text: "Cancel"
                onClicked: {
                    itemsInFridgeModel.loadItemsFromFile()
                    stackView.pop()
                }
            }
        }
    }
}
