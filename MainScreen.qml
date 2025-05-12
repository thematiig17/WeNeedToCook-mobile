import QtQuick 2.15
import QtQuick.Controls 2.15

Item {
    Button {
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
    }

    // dostęp do stackView przez parent
    function getStackView() {
        var p = parent
        while (p && !p.push) p = p.parent
        return p
    }

    Component.onCompleted: {
        stackView = getStackView()
    }

    property var stackView
}
