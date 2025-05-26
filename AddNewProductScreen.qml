import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

Item {
    Page {
        title: "Dodaj produkt"

        ColumnLayout {
            anchors.centerIn: parent
            spacing: 10
            width: parent.width * 0.8

            TextField {
                id: nameField
                placeholderText: "Nazwa"
            }

            TextField {
                id: descField
                placeholderText: "Opis"
            }

            SpinBox {
                id: countField
                from: 0
                to: 999
                value: 1
            }

            Button {
                text: "Dodaj"
                onClicked: {
                    itemsInFridgeModel.addItem(nameField.text, descField.text, countField.value)
                    stackView.pop() // wróć do listy
                }
            }

            Button {
                text: "Anuluj"
                onClicked: stackView.pop()
            }
        }
    }
}
