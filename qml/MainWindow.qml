import QtQuick 2.15
import QtQuick.Controls.Material

ApplicationWindow {
    id: mainWindow
    width: 640
    height: 480
    visible: true
    title: qsTr("File on Schedule 2")

    Rectangle{
        anchors{
            top: parent.top
            right: parent.right
            left: parent.left
        }
        height: parent.height * 0.15

        color: "red"

        Button{
            anchors{
                top: parent.top
                left: parent.left
                bottom: parent.bottom
                right: text_.left
            }
            text: "<-"

            onClicked: {
                WeekEvents.prevWeek();
            }
        }

        Text{
            id: text_
            anchors{
                top: parent.top
                bottom: parent.bottom
                horizontalCenter: parent.horizontalCenter
            }
            width: parent.width * 0.7
            text: WeekEvents.currentWeek
        }


        Button{
            anchors{
                top: parent.top
                right: parent.right
                bottom: parent.bottom
                left: text_.right
            }
            text: "->"
            onClicked: {
                WeekEvents.nextWeek();
            }
        }

    }
}
