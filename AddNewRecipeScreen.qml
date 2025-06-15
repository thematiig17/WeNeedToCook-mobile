
import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import Recipe.Models 1.0

Page {
    id: addRecipePage
    title: "Add new recipe"
    Rectangle {
        anchors.fill: parent
        color: "#FAF0DC"
        z:0
    }

    ListModel {
        id: ingredientsModel
    }

    ScrollView {
        width: parent.width * 0.9
        anchors.centerIn: parent
        height: parent.height
        spacing: 10
        anchors.topMargin: 20

        ColumnLayout {
            width: parent.width
            anchors.centerIn: parent
            spacing: 10

            Text {
                text: "Add new recipe"
                font.pointSize: 24
                font.bold: true
                horizontalAlignment: Text.AlignHCenter
                Layout.alignment: Qt.AlignHCenter
            }

            TextField {
                id: nameField
                placeholderText: "Recipe name"
                Layout.fillWidth: true
            }

            TextArea {
                id: noteArea
                placeholderText: "Description"
                wrapMode: TextEdit.Wrap
                Layout.fillWidth: true
                Layout.preferredHeight: 100
            }

            Text {
                text: "Ingredients"
                font.bold: true
                Layout.topMargin: 10
            }

            Repeater {
                model: ingredientsModel
                delegate: RowLayout {
                    spacing: 8

                    TextField {
                        placeholderText: "Name"
                        text: model.name
                        onTextChanged: ingredientsModel.setProperty(index, "name", text)
                        Layout.preferredWidth: 120
                    }

                    TextField {
                        placeholderText: "Amount"
                        text: model.amount
                        inputMethodHints: Qt.ImhFormattedNumbersOnly
                        onTextChanged: ingredientsModel.setProperty(index, "amount", text)
                        Layout.preferredWidth: 60
                    }

                    ComboBox {
                        model: ["g", "ml", "pcs"]
                        currentIndex: find(model.unit)
                        onCurrentTextChanged: ingredientsModel.setProperty(index, "unit", currentText)
                        Layout.preferredWidth: 80
                    }

                    Button {
                        text: "-"
                        onClicked: ingredientsModel.remove(index)
                    }
                }
            }

            Button {
                text: "Add ingredient"
                onClicked: ingredientsModel.append({ name: "", amount: "", unit: "g" })
            }

            RowLayout {
                Layout.topMargin: 20
                spacing: 10

                Button {
                    text: "Cancel"
                    onClicked: {
                        RecipeModel.loadItemsFromFile()
                        stackView.pop()
                    }
                }

                Button {
                    text: "Add"
                    onClicked: {
                        var names = []
                        var amounts = []
                        var units = []

                        for (var i = 0; i < ingredientsModel.count; ++i) {
                            var item = ingredientsModel.get(i)
                            names.push(item.name)
                            amounts.push(Number(item.amount))
                            units.push(item.unit)
                        }

                        RecipeModel.addItemToFile(nameField.text, noteArea.text, names, amounts, units)

                        RecipeModel.loadItemsFromFile()
                        stackView.pop()
                    }
                }
            }
        }
    }
}
