import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

Item {
    Button {
        text: "Go Back"
        background: Rectangle {
        anchors.fill: parent
        color: "SteelBlue"
        radius: 30
        opacity: 1.0
}
        width : 120
        height : 60
        anchors.left: parent.left
        anchors.bottom: parent.bottom
        anchors.margins: 16

        onClicked: {
            var view = parent
            while (view && !view.pop) view = view.parent
            if (view) view.pop()
        }
    }
    ColumnLayout {
        spacing: 20
        anchors.right: parent.right
        anchors.left: parent.left
        anchors.leftMargin: 10
        anchors.rightMargin: 10
        width: parent.width
        anchors.topMargin: 60

    Text{
        text: "My fridge"
        color: "black"
        font.pixelSize : 30
        Layout.topMargin: 10
        horizontalAlignment: Text.AlignHCenter
        width: parent.width
        anchors.horizontalCenter: parent.horizontalCenter
        Layout.bottomMargin: -5
    }

    //TEST DO USUNIECIA POTEM
    Button {
        text: "Dodaj testowe dane"
        onClicked: {
            FileIO.createExampleJson()

        }
    }
    //TEST DO USUNIECIA POTEM

    Rectangle {
        width: parent.width
        height: 1
        color: "black"
    }
        Repeater{
            model: itemsInFridgeModel

        delegate: Item{
            width:parent.width
            height: 50


        Column {
            spacing: 6
            anchors.fill: parent

        RowLayout{
            spacing: 10
            Layout.fillWidth: true


                Text {
                    text: model.name
                    font.bold: true
                    Layout.alignment: Qt.AlignLeft
                    Layout.preferredWidth: 200
                    elide: Text.ElideRight

                }

                Item {
                    Layout.fillWidth: true
                }

                Text {
                    text: model.count
                    Layout.alignment: Qt.AlignRight
                    horizontalAlignment: Text.AlignRight
                    Layout.preferredWidth: 120

                }
            }

                Row{
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
    Button {
        text: "<font color=\"#FFFFFF\">+</font>"
        font.pixelSize : 22
        width : 60
        height : 60
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        anchors.margins: 16
        onClicked: stackView.push("AddNewProductScreen.qml")
        background: Rectangle {
        color: "SteelBlue"
        radius: 30
    }
    }
}
}
