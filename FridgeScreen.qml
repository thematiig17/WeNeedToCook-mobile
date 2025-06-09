import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import App.Models 1.0

Item {
    Button {
        text: "<font color=\"#FFFFFF\"> GO BACK</font>"
        font.pixelSize : 22
        background: Rectangle {
        color: "SteelBlue"
        radius: 20
        opacity: 1.0
}
        width : 140
        height :35
        anchors.left: parent.left
        anchors.bottom: parent.bottom
        anchors.margins: 16

        onClicked: stackView.pop() /*{
            var view = parent
            while (view && !view.pop) view = view.parent
            if (view) view.pop()
            } */
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
        text: "My Fridge"
        color: "black"
        font.pixelSize : 30
        Layout.topMargin: 10
        horizontalAlignment: Text.AlignHCenter
        width: parent.width
        anchors.horizontalCenter: parent.horizontalCenter
        Layout.bottomMargin: -5
    }

    //TEST DO USUNIECIA POTEM
    RowLayout {
        spacing: 20
        Button {
            text: "Dodaj testowe dane"
            onClicked: {
                FileIO.createExampleJson("FridgeData")
                stackView.pop()
                FridgeModel.loadItemsFromFile()
                stackView.push("FridgeScreen.qml")
            }
        }
        Button {
            text: "Usun wszystkie dane"
            onClicked: {
                FileIO.deleteJson("FridgeData")
                stackView.pop()
                FridgeModel.loadItemsFromFile()
                stackView.push("FridgeScreen.qml")
            }
        }
    }


    //TEST DO USUNIECIA POTEM

    Text { text: "Model count: " + FridgeModel.count }

    ListView {
        //anchors.fill: parent
        Layout.fillWidth: true
        Layout.fillHeight: true
        clip: true
        model: FridgeModel

        header: Rectangle {
            width: parent.width
            height: 1
            color: "black"
        }

        delegate: Item {
            width: parent.width
            height: 50

            Column {
                spacing: 6
                anchors.fill: parent

                RowLayout{
                    spacing: 10
                    Layout.fillWidth: true

                    Text {
                        text: name
                        font.pixelSize : 22
                        font.bold: true
                        Layout.alignment: Qt.AlignLeft
                        Layout.preferredWidth: 200
                        elide: Text.ElideRight

                    }

                    Item {
                        Layout.fillWidth: true
                    }

                    Text {
                        //text: count + unit
                        text: {
                                if (unit === "ml" && count > 1000) {
                                    return (count / 1000) + "L";
                                } else if (unit === "g" && count >= 1000) {
                                    return (count / 1000) + "kg";
                                } else {
                                    return count + unit;
                                }
                            }
                        font.pixelSize : 22
                        Layout.alignment: Qt.AlignRight
                        horizontalAlignment: Text.AlignRight
                        Layout.preferredWidth: 120
                    }
                }

                Row {
                    spacing:4

                    Repeater{
                        model: 50

                        Rectangle{
                            width : 4
                            height:2
                            color: "black"
                        }


                    }
                }
            }
        }
    }


    }
    Button {
        text: "<font color=\"#FFFFFF\">+</font>"
        font.pixelSize : 22
        background: Rectangle {
        color: "SteelBlue"
        radius: 20
        opacity: 1.0
}
        width : 40
        height : 40
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        anchors.margins: 16
        onClicked: stackView.push("AddNewProductScreen.qml")

}
}
