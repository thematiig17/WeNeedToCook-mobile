import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import Recipe.Models 1.0
import DebugMode
import ShoppingList.Models
import App.Models

Item {
    Rectangle {
        anchors.fill: parent
        color: "#FAF0DC"
        z: 0
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
            text: "My Recipes"
            color: "#3A3B3C"
            font.pixelSize : 30
            Layout.topMargin: 10
            horizontalAlignment: Text.AlignHCenter
            width: parent.width
            anchors.horizontalCenter: parent.horizontalCenter
            Layout.bottomMargin: -5
        }
        RowLayout {
            spacing: 20
            id: debugButtons
            Button {
                text: "Dodaj testowe dane"
                onClicked: {
                    FileIO.createExampleJson("RecipeData")
                    stackView.pop()
                    RecipeModel.loadItemsFromFile()
                    stackView.push("RecipeScreen.qml")
                }
            }
            Button {
                text: "Usun wszystkie dane"
                onClicked: {
                    FileIO.deleteJson("RecipeData")
                    stackView.pop()
                    RecipeModel.loadItemsFromFile()
                    stackView.push("RecipeScreen.qml")
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
            Layout.fillWidth: true
            Layout.fillHeight: true
            clip: true
            model: RecipeModel

            delegate: Item {
                width: parent.width
                height: 80 + ingredients.length * 24 +(showNote ? noteText.implicitHeight + 50 :0)
                property bool showNote: false

                MouseArea {
                    id: clickArea
                    width: parent.width
                    height: 50
                    onClicked: showNote = !showNote

                    Column {
                        spacing: 2
                        anchors.fill: parent

                        RowLayout{
                            spacing: 120
                            Layout.fillWidth: true

                            Button{
                                id: useIngredientsButton
                                text: "<font color=\"#3A3B3C\">Use ingredients</font>"
                                background: Rectangle {
                                    color: "#EA917E"
                                    border.color: "#DA5033"
                                    border.width:3
                                    radius: 5
                                    opacity: 1.0
                                }
                                width : 120
                                height :30

                                onClicked: {
                                    if(FridgeModel.searchForMultipleItems(ingredients, quantity, units)){
                                        stackView.push("NotEnoughItems.qml")
                                    } else {
                                        FridgeModel.decreaseMultipleItems(ingredients, quantity, units)
                                        useIngredientsButton.text = "<font color=\"#3A3B3C\">Done! ⠀⠀⠀ ⠀⠀⠀</font>"
                                    }
                                }
                            }
                            Button{
                                text: "<font color=\"#3A3B3C\">Add to ShopList</font>"
                                background: Rectangle {
                                    color: "#76C2E9"
                                    border.color: "SteelBlue"
                                    border.width:3
                                    radius: 5
                                    opacity: 1.0
                                }
                                width : 140
                                height :30
                                onClicked: {
                                   ShoppingListModel.addMultipleItemsToFile(ingredients, quantity, units)
                                }
                            }
                        }
                        Text {
                            text: name
                            color:"#3A3B3C"
                            font.pixelSize : 22
                            font.bold: true
                            Layout.alignment: Qt.AlignLeft
                            horizontalAlignment: Text.AlignHCenter
                            anchors.horizontalCenter: parent.horizontalCenter
                            Layout.preferredWidth: 200
                            elide: Text.ElideRight
                        }
                        Item {
                            Layout.fillWidth: true
                        }
                        Repeater {
                           model: ingredients.length
                           Row {
                               spacing: 6
                               Text {
                                   text: ingredients[index] + ":"
                                   color:"#3A3B3C"
                               }
                               Text {
                                   text: quantity[index]
                                   color:"#3A3B3C"
                               }
                               Text {
                                   text: units[index]
                                   color:"#3A3B3C"
                               }
                           }
                        }
                        Item{
                            width: parent.width
                            visible: showNote
                            height: showNote ? noteText.implicitHeight + 50 : 0 // padding
                            Behavior on height { NumberAnimation { duration: 200 } }

                            Text {
                                id: noteText
                                anchors.fill: parent
                                anchors.margins: 10
                                text: description
                                wrapMode: Text.Wrap
                                font.pixelSize: 18
                                color: "#3A3B3C"
                                visible: parent.visible
                            }

                            Row{
                                spacing:250
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
                                    onClicked: {
                                        FileIO.deleteByName("RecipeData", name)
                                        stackView.pop()
                                        RecipeModel.loadItemsFromFile()
                                        stackView.push("RecipeScreen.qml")
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
                                        console.log("DANE EDYTOWANE:", name, description, units)
                                        stackView.push("EditRecipeScreen.qml", {"passedName": name, "passedDesc": description, "passedIngredients": ingredients, "passedQuantity": quantity, "passedUnits": units})
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
                border.color: "#EED0B6"
                border.width: 3
                radius: 5
                opacity: 1.0
            }
            width : 140
            height :35
            anchors.left: parent.left
            anchors.bottom: parent.bottom
            anchors.margins: 16
            onClicked: stackView.pop()
        }
    }
    Button {
        text: "<font color=\"#3A3B3C\">+</font>"
        font.pixelSize : 26
        background: Rectangle {
            color: "white"
            border.color: "#EED0B6"
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
        onClicked: stackView.push("AddNewRecipeScreen.qml")
    }
}
