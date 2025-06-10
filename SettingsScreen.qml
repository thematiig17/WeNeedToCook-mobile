import QtQuick
import QtQuick.Controls
import DebugMode

Item {
    Button {
        text: "Wróć"
        anchors.centerIn: parent
        onClicked: {
            if (debugModeEnabled.checked) {
                DebugMode.isDebugModeEnabled = true
                DebugMode.enableDebugMode()
                console.log("enabled Debug Mode (qml)")
                console.log(DebugMode.isDebugModeEnabled)
            } else {
                DebugMode.isDebugModeEnabled = false
                DebugMode.disableDebugMode()
                console.log("disabled Debug Mode (qml)")
                console.log(DebugMode.debugModeStatus)
            }

            var view = parent
            while (view && !view.pop) view = view.parent
            if (view) view.pop()
        }
    }
    CheckBox {
        id: debugModeEnabled
        text: qsTr("Debug mode")
        checked: DebugMode.debugModeStatus()
    }

}
