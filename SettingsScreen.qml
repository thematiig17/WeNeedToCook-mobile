import QtQuick 2.15
import QtQuick.Controls 2.15

Item {
    property StackView stackView

    Button {
        text: "Wróć"
        anchors.centerIn: parent
        onClicked: {
            if (stackView) {
                stackView.pop()
            } else {
                console.warn("Brak referencji do stackView!")
            }
        }
    }
}
