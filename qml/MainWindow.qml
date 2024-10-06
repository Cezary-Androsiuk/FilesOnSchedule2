import QtQuick 2.15
import QtQuick.Controls.Material

ApplicationWindow {
    id: mainWindow
    width: 1280
    minimumWidth: 400
    height: 720
    minimumHeight: 160
    visible: true
    visibility: Window.Maximized // probably do not affect on application right now (requires .showMaximized())
    title: qsTr("File on Schedule 2")

    StackView{
        id: mainStackView
        anchors.fill: parent

        initialItem: MainContent{}
        pushEnter: Transition {
            PropertyAnimation {
                property: "opacity"
                from: 0
                to:1
                duration: 200
            }
        }
        pushExit: Transition {
            PropertyAnimation {
                property: "opacity"
                from: 1
                to: 1
                duration: 200
            }
        }
        popEnter: Transition {
            PropertyAnimation {
                property: "opacity"
                from: 1
                to: 1
                duration: 200
            }
        }
        popExit: Transition {
            PropertyAnimation {
                property: "opacity"
                from: 1
                to:0
                duration: 200
            }
        }
    }
}
