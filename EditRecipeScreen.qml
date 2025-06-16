
import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import Recipe.Models 1.0

Page {
    id: editRecipePage
    property var passedName
    property var passedDesc
    property var passedIngredients //tablica
    property var passedQuantity //tablica
    property var passedUnits //tablica
    title: "Edit existing recipe"

    Component.onCompleted: {
        ingredientsModel.clear();
        for (var i = 0; i < passedIngredients.length; ++i) {
            ingredientsModel.append({
                "name": passedIngredients[i],
                "amount": passedQuantity[i],
                "unit": passedUnits[i]
            });
        }
    }

    Rectangle {
        anchors.fill: parent
        color: "#f2f2f7"
        z:0
    }

    ListModel {
        id: ingredientsModel
    }

    ScrollView {
        width: parent.width
        anchors.centerIn: parent
        height: parent.height
        spacing: 10
        anchors.topMargin: 20

        ColumnLayout {
            spacing: 10
            width: parent.width * 0.9
            height:50
            anchors.horizontalCenter: parent.horizontalCenter

            Text{
                text:"Edit existing recipe"
                color:"#3A3B3C"
                font.bold:true
                font.pointSize: 33
                anchors.topMargin: 30
                anchors.horizontalCenter: parent.horizontalCenter

            }
            Row {
                spacing: 10
                Text{
                    text: "Recipe name: "
                    color: "#3A3B3C"
                }
                TextField {
                    id: nameField
                    Layout.fillWidth: true
                    text: passedName
                    height:30
                    width:150
                    background: Rectangle {
                                color: "white"
                                border.color: "#EED0B6"
                                border.width: 2
                                radius: 4
                                }
                }
            }
            Row {
                spacing: 10
                Text{
                    text: "Descrpition: "
                    color: "#3A3B3C"
                }
                TextArea {
                    id: noteArea
                    text: passedDesc
                    wrapMode: TextEdit.Wrap
                    Layout.fillWidth: true
                    Layout.preferredHeight: 100
                    height:150
                    width:250
                    background: Rectangle {
                                color: "white"
                                border.color: "#EED0B6"
                                border.width: 2
                                radius: 4
                                }
                }
            }
            Row {
                spacing: 10
                Text {
                    text: "Ingredients:"
                     color: "#3A3B3C"
                    Layout.topMargin: 10
                }
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
                        background: Rectangle {
                                    color: "white"
                                    border.color: "#EED0B6"
                                    border.width: 2
                                    radius: 4
                                    }
                    }

                    TextField {
                        placeholderText: "Amount"
                        text: model.amount
                        inputMethodHints: Qt.ImhFormattedNumbersOnly
                        onTextChanged: ingredientsModel.setProperty(index, "amount", text)
                        Layout.preferredWidth: 100
                        background: Rectangle {
                                    color: "white"
                                    border.color: "#EED0B6"
                                    border.width: 2
                                    radius: 4
                                    }
                    }

                    ComboBox {
                        id: unitCombo
                        model: ["g", "ml", "pcs"]
                        currentIndex: {
                            var u = ingredientsModel.get(index).unit;
                            var i = unitCombo.model.indexOf(u);
                            return i >= 0 ? i : 0;
                        }
                        onCurrentTextChanged: ingredientsModel.setProperty(index, "unit", currentText)
                        Layout.preferredWidth: 85
                        Layout.preferredHeight: 35
                        background: Rectangle {
                                    color: "white"
                                    border.color: "#EED0B6"
                                    border.width: 2
                                    radius: 4
                                    }
                    }

                    Button {
                        text: "<font color=\"#FFFFFF\">-</font>"
                        background: Rectangle {
                            color: "#EA5C44"
                            border.color: "#EA5C44"
                            border.width: 3
                            radius: 5
                            opacity: 1.0
                        }
                        width : 80
                        height : 40
                        onClicked: ingredientsModel.remove(index)
                    }
                }
            }

            Button {
                text: "<font color=\"#3A3B3C\">Add ingredient</font>"
                background: Rectangle {
                    color: "white"
                    border.color: "#EED0B6"
                    border.width: 3
                    radius: 5
                    opacity: 1.0
                }
                width : 80
                height : 40
                onClicked: ingredientsModel.append({ name: "", amount: "", unit: "g" })
            }
            Item {
                height: 30
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
                    anchors.topMargin: 20

                    onClicked: {
                        RecipeModel.loadItemsFromFile()
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
                    anchors.margins: -350
                    anchors.topMargin: 20


                    onClicked:  {
                        var names = []
                        var amounts = []
                        var units = []

                        for (var i = 0; i < ingredientsModel.count; ++i) {
                            var item = ingredientsModel.get(i)
                            names.push(item.name)
                            amounts.push(Number(item.amount))
                            units.push(item.unit)
                        }

                        FileIO.editExistingEntry("RecipeData", passedName, FileIO.makeJsonFromRecipe(nameField.text, noteArea.text, names, amounts, units))

                        RecipeModel.loadItemsFromFile()
                        stackView.pop()
                    }
                }
            }
        }
    }
}
