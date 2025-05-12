import QtQuick 2.15
import QtQuick.Controls 2.15

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
