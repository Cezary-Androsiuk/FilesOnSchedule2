import QtQuick 2.15
import QtQuick.Controls.Material

Item {
    id: dayList

    required property int day;

    ListView{
        id: listView
        anchors.fill: parent
        // interactive: false
        model: 24
        boundsBehavior: Flickable.StopAtBounds
        clip: true
        delegate: Item{
            Rectangle{
                anchors{
                    top: parent.top
                    left: parent.left
                    right: parent.right
                }
                height: 1
                color: Qt.rgba(1.0/24*(index),1.0/24*(index),1.0/24*(index),1.0)
            }

            height: listView.height / 24
            width: listView.width

            Text{
                anchors.centerIn: parent
                text: day + "-" + index
            }
        }
    }
}
