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
        spacing: 30
        anchors.horizontalCenter: parent.horizontalCenter
        Text {
            Layout.topMargin: 80
            Layout.alignment: Qt.AlignHCenter //wysrodkowanie
            font.pointSize: 48 //wielkosc tekstu
            font.family: "Helvetica" //czcionka
            text: "WeNeedToCook"
            color: "#3A3B3C"
            font.bold: true
        }

        Text {
            Layout.bottomMargin: 30
            Layout.alignment: Qt.AlignHCenter //wysrodkowanie
            font.pointSize: 36 //wielkosc tekstu
            font.family: "Helvetica" //czcionka
            id: hello_user //id
            text: "Hello " + UserVariables.getNameOfUser() + "!"
            color: "#3A3B3C"
        }

        Rectangle{//tutaj warning trzeba dodac
            color: "transparent"
            Layout.fillWidth: true
        }

              //Text {
             //Layout.alignment: Qt.AlignHCenter //wysrodkowanie
            //font.pointSize: 18 //wielkosc tekstu
           // font.family: "Helvetica" //czcionka
          //  id: welcome_dialog //id
         //   text: qsTr("Please select one of the options below.")
        //    color: "#3A3B3C"
       // }
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

    } //afterColumnLayout
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
                    text: "BLANK"
                    color: "#3A3B3C"
                }
            }
            Rectangle{
                Layout.fillWidth: true
                Layout.fillHeight: true
                color: "white"
                Text{
                    anchors.centerIn: parent
                    text: "QUE?"
                    color: "#3A3B3C"
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




