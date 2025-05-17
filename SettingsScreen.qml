import QtQuick
import QtQuick.Controls

Item {
    Button {
        text: "Wróć"
        anchors.centerIn: parent
        onClicked: {
            var view = parent
            while (view && !view.pop) view = view.parent
            if (view) view.pop()
        }
    }
}
