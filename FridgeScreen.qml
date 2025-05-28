import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

Item {
    Button {
        text: "Go Back"
        background: Rectangle {
        color: "SteelBlue"
        radius: 30
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

    Rectangle {
        width: parent.width
        height: 1
        color: "black"
    }
        Repeater{
            model: itemsInFridgeModel
            Rectangle{
                Layout.fillWidth: true
                height: 10
                color: "blue"
            }
            RowLayout{
                Layout.fillWidth: true
                spacing: 10

                Text {
                    text: model.name
                    font.bold: true

                }

                // Pusta przestrzeń rozciągająca RowLayout
                Item {
                    Layout.fillWidth: true
                }

                Text {
                    text: model.count
                    horizontalAlignment: Text.AlignRight
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
