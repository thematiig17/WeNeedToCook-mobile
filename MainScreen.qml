import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import App.Models 1.0
import Recipe.Models 1.0
import ShoppingList.Models 1.0
import UserVariables

Page {
    id: mainScreenRoot
    Rectangle {
        anchors.fill: parent
        color: "#FAF0DC" // lub inny kolor tła, np. "#ffffff"
        z: 0 // tło musi być pod innymi elementami
    }

    ColumnLayout{
        spacing: 20
        anchors.horizontalCenter: parent.horizontalCenter
        Text {
            Layout.topMargin: 60
            Layout.alignment: Qt.AlignHCenter //wysrodkowanie
            font.pointSize: 40 //wielkosc tekstu
            font.family: "Helvetica" //czcionka
            text: "WeNeedToCook"
            color: "#3A3B3C"
            font.bold: true
        }

        Text {
            Layout.alignment: Qt.AlignHCenter //wysrodkowanie
            font.pointSize: 28 //wielkosc tekstu
            font.family: "Helvetica" //czcionka
            id: hello_user //id
            text: "Hello " + UserVariables.getNameOfUser() + "!"
            color: "#3A3B3C"
        }

        Rectangle{
            color: "transparent"
            Layout.fillWidth: true
        }

        RowLayout{
            spacing: 30
            Rectangle {
                Layout.fillWidth: true
                Layout.preferredHeight: 150
                color: "white"
                border.width: 3
                border.color: "#EED0B6"
                radius: 25
                Text{
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.centerIn: parent
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                    text: "Fridge"
                    font.pointSize: 30
                    font.bold: true
                    color: "#3A3B3C"
                }
                MouseArea {
                    anchors.fill: parent
                    onClicked: {
                        console.log("Open Fridge")
                        FridgeModel.loadItemsFromFile()
                        stackView.push("FridgeScreen.qml")
                    }
                }
            }
        }
        RowLayout{
            spacing: 30
            Rectangle {
                Layout.fillWidth: true
                Layout.preferredHeight: 150
                color: "white"
                border.width: 3
                border.color: "#EED0B6"
                radius: 25
                Text{
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.centerIn: parent
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                    text: "Shopping List"
                    font.pointSize: 30
                    font.bold: true
                    color: "#3A3B3C"
                }

                MouseArea {
                    anchors.fill: parent
                    onClicked: {
                        console.log("Open Shopping List")
                        ShoppingListModel.loadItemsFromFile()
                        stackView.push("ShoppingListScreen.qml")
                    }
                }
            }
        }
        RowLayout{
            spacing: 30
            Rectangle {
                Layout.fillWidth: true
                Layout.preferredHeight: 150
                color: "white"
                border.width: 3
                border.color: "#EED0B6"
                radius: 25
                Text{
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.centerIn: parent
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                    text: "Recipes"
                    font.pointSize: 30
                    font.bold: true
                    color: "#3A3B3C"
                }

                MouseArea {
                    anchors.fill: parent
                    onClicked: {
                        console.log("Open Reciepes")
                        RecipeModel.loadItemsFromFile()
                        stackView.push("RecipeScreen.qml")
                    }
                }
            }
        }

    }
    Rectangle{
        anchors.bottom: parent.bottom
        height: 50
        width: parent.width
        color: "#EED0B6"
        border.color: "#EED0B6"
        border.width: 3
        RowLayout{
            anchors.fill: parent
            anchors.margins: 2
            spacing: 2
            Rectangle{
                Layout.fillWidth: true
                Layout.fillHeight: true
                color: "white"
                Text{
                    anchors.centerIn: parent
                    text: "TEAM"
                    color: "#3A3B3C"
                }
                MouseArea {
                    anchors.fill: parent
                    onClicked: {
                        stackView.push("TeamScreen.qml")
                    }
                }
            }
            Rectangle{
                Layout.fillWidth: true
                Layout.fillHeight: true
                color: "white"
                Text{
                    anchors.centerIn: parent
                    text: "INFO"
                    color: "#3A3B3C"
                }
                MouseArea {
                    anchors.fill: parent
                    onClicked: {
                        stackView.push("InfoScreen.qml")
                    }
                }
            }
            Rectangle{
                Layout.fillWidth: true
                Layout.fillHeight: true
                color: "white"
                Text{
                    anchors.centerIn: parent
                    text: "SETT"
                    color: "#3A3B3C"
                }
                MouseArea {
                    anchors.fill: parent
                    onClicked: {
                        stackView.push("SettingsScreen.qml")
                    }
                }

            }

        }


    }
    onVisibleChanged: {
        if (visible) {
            hello_user.text = "Hello " + UserVariables.getNameOfUser() + "!"
        }
    }
}




