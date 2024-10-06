import QtQuick 2.15
import QtQuick.Layouts
import QtQuick.Controls.Material

Item {
    id: settings

    ToolBar {
        id: toolBarHeader
        anchors{
            top: parent.top
            left: parent.left
            right: parent.right
        }
        height: 50

        ToolButton{
            anchors{
                left: parent.left
                verticalCenter: parent.verticalCenter
            }
            display: AbstractButton.IconOnly
            // icon.source: Qt.resolvedUrl("qrc:/FilesOnSchedule2/icons/back.svg")
            icon.source: Qt.resolvedUrl("qrc:/FilesOnSchedule2/icons/back_filled.svg")
            icon.height: height * 0.4
            icon.width: width * 0.4
            onClicked: {
                mainStackView.pop()
            }
        }

        Item{
            id: titleOfPageField // idk?
            anchors{
                top: parent.top
                bottom: parent.bottom
                horizontalCenter: parent.horizontalCenter
            }
            width: 300
            Label {
                anchors.centerIn: parent
                text: "Add Event"
                elide: Label.ElideRight
                horizontalAlignment: Qt.AlignHCenter
                verticalAlignment: Qt.AlignVCenter
                Layout.fillWidth: true
            }
        }


    }


    ListView{
        id: listView
        anchors{
            top: toolBarHeader.bottom
            left: parent.left
            right: parent.right
            bottom: parent.bottom
        }
        // interactive: false
        model: 40
        boundsBehavior: Flickable.StopAtBounds
        clip: true
        delegate: Rectangle{
            color: Qt.rgba(1.0/40*(index),1.0/40*(index),1.0/40*(index),1.0)
            height: 30
            width: listView.width

            Text{
                anchors.centerIn: parent
                text: index
            }
        }
    }
}
