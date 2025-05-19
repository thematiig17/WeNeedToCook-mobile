import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

Item {
    Button {
        text: "< Wróć"
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
                    text: "Nazwa: " + model.name
                    font.bold: true
                }
                Text {
                    text: "Opis: " + model.desc
                }
                Text {
                    text: "Liczba: " + model.count
                }
            }
        }

    }
}
