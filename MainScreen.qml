import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import App.Models 1.0
import Recipe.Models 1.0
import ShoppingList.Models 1.0
import UserVariables

Page {
    id: mainScreenRoot

    ColumnLayout{
        spacing: 30
        anchors.horizontalCenter: parent.horizontalCenter
        //testowe
        Text {
            text: "Fridge count: " + FridgeModel.count
            anchors.top: parent.top
            anchors.horizontalCenter: parent.horizontalCenter
        }
        Text {
            Layout.topMargin: 100
            Layout.alignment: Qt.AlignHCenter //wysrodkowanie
            font.pointSize: 48 //wielkosc tekstu
            font.family: "Helvetica" //czcionka
            id: hello_user //id
            text: "Hello " + UserVariables.getNameOfUser() + "!"
        }

        Rectangle{//tutaj warning trzeba dodac
            height: 50
            color: "transparent"
            Layout.fillWidth: true
        }

        Text {
            Layout.alignment: Qt.AlignHCenter //wysrodkowanie
            font.pointSize: 18 //wielkosc tekstu
            font.family: "Helvetica" //czcionka
            id: welcome_dialog //id
            text: qsTr("Please select one of the options below.")
        }
        RowLayout{
            spacing: 30
            Rectangle {
                Layout.fillWidth: true
                Layout.preferredHeight: 150
                color: "lightgray"
                Text{
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.bottom: parent.bottom
                    anchors.bottomMargin: 10
                    text: "Shopping List"
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
            Rectangle {
                Layout.fillWidth: true
                Layout.preferredHeight: 150
                color: "lightgray"
                Text{
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.bottom: parent.bottom
                    anchors.bottomMargin: 10
                    text: "Fridge"
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
                color: "lightgray"
                Text{
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.bottom: parent.bottom
                    anchors.bottomMargin: 10
                    text: "Recipes"
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
            Rectangle {
                Layout.fillWidth: true
                Layout.preferredHeight: 150
                color: "lightgray"
                Text{
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.bottom: parent.bottom
                    anchors.bottomMargin: 10
                    text: "iwi"
                }

                MouseArea {
                    anchors.fill: parent
                    onClicked: {
                        console.log("BLANK")
                    }
                }
            }
        }
    } //afterColumnLayout
    Rectangle{
        anchors.bottom: parent.bottom
        height: 50
        width: parent.width
        color: "black"
        border.color: "black"
        border.width: 2
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
                    text: "BLANK"
                }
            }
            Rectangle{
                Layout.fillWidth: true
                Layout.fillHeight: true
                color: "white"
                Text{
                    anchors.centerIn: parent
                    text: "QUE?"
                }
            }
            Rectangle{
                Layout.fillWidth: true
                Layout.fillHeight: true
                color: "white"
                Text{
                    anchors.centerIn: parent
                    text: "INFO"
                }
            }
            Rectangle{
                Layout.fillWidth: true
                Layout.fillHeight: true
                color: "white"
                Text{
                    anchors.centerIn: parent
                    text: "SETT"
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

    /*Button { //STARY KOD
        text: "Idź do ustawień"
        anchors.centerIn: parent
        onClicked: stackView.push("SettingsScreen.qml")

        anchors.horizontalCenter: parent.horizontalCenter
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 40  // opcjonalnie: odstęp od dołu
        anchors.left: parent.left
        anchors.leftMargin: 20
        anchors.right: parent.right
        anchors.rightMargin: 20
    }*/

    // dostęp do stackView przez parent
    /*function getStackView() {
        var p = parent
        while (p && !p.push) p = p.parent
        return p
    }

    Component.onCompleted: {
        stackView = getStackView()
    }

    property var stackView*/

    onVisibleChanged: {
            if (visible) {
                hello_user.text = "Hello " + UserVariables.getNameOfUser() + "!"
            }
        }
}




