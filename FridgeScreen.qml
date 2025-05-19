import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

Item {
    Button {
        text: "< Back"
        anchors.left: parent.left
        anchors.top: parent.top
        anchors.leftMargin: 10
        anchors.topMargin: 10
        onClicked: {
            var view = parent
            while (view && !view.pop) view = view.parent
            if (view) view.pop()
        }
    }

    ColumnLayout {
        spacing: 30
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: parent.top
        anchors.topMargin: 60

        Repeater{
            model: itemsInFridgeModel
            Rectangle{
                Layout.fillWidth: true
                height: 10
                color: "gray"
            }
            RowLayout{
                Layout.fillWidth: true
                spacing: 10

                Text {
                    text: "Name: " + model.name
                    font.bold: true
                }
                Text {
                    text: "Desc: " + model.description
                }
                // Pusta przestrzeń rozciągająca RowLayout
                Item {
                    Layout.fillWidth: true
                }

                Text {
                    text: "Count: " + model.count
                    horizontalAlignment: Text.AlignRight
                }
            }
        }

    }
    Button {
        text: "Dodaj produkt"
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        anchors.margins: 16
        onClicked: stackView.push("AddNewProductScreen.qml")
    }
}
