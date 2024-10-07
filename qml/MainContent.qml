import QtQuick 2.15
import QtQuick.Layouts
import QtQuick.Controls.Material

Item {
    id: mainContent

    function widthOfField(indexValue)
    {
        const partsInWidth = 7*3 + 1 // 7 parts of schedule(with width of 3) and 1 part of left menu(with width of 1)
        if(indexValue === 0)
            return mainContent.width * (1/partsInWidth)
        else
            return mainContent.width * (3/partsInWidth)

    }

    ToolBar {
        id: toolBarHeader
        anchors{
            top: parent.top
            left: parent.left
            right: parent.right
        }
        height: 50

        ToolButton{
            id: settingsButton
            anchors{
                left: parent.left
                verticalCenter: parent.verticalCenter
            }
            display: AbstractButton.IconOnly
            // icon.source: Qt.resolvedUrl("qrc:/FilesOnSchedule2/icons/settings.svg")
            icon.source: Qt.resolvedUrl("qrc:/FilesOnSchedule2/icons/settings_filled.svg")
            icon.height: height * 0.4
            icon.width: width * 0.4
            onClicked: {
                mainStackView.push(Qt.resolvedUrl("Settings.qml"))
            }
        }

        Item{
            id: currentWeekField
            anchors{
                top: parent.top
                bottom: parent.bottom
                horizontalCenter: parent.horizontalCenter
            }
            width: 300

            ToolButton {
                anchors{
                    left: parent.left
                    verticalCenter: parent.verticalCenter
                }
                display: AbstractButton.IconOnly
                // icon.source: Qt.resolvedUrl("qrc:/FilesOnSchedule2/icons/back.svg")
                icon.source: Qt.resolvedUrl("qrc:/FilesOnSchedule2/icons/back_filled.svg")
                icon.height: height * 0.35
                icon.width: width * 0.35
                onClicked: {
                    WeekEvents.prevWeek();

                    // refresh loader
                    scheduleLoader.sourceComponent = null
                    scheduleLoader.sourceComponent = listViewComponent
                }
            }
            Label {
                anchors.centerIn: parent
                text: WeekEvents.currentWeek
                elide: Label.ElideRight
                horizontalAlignment: Qt.AlignHCenter
                verticalAlignment: Qt.AlignVCenter
                Layout.fillWidth: true
            }
            ToolButton {
                anchors{
                    right: parent.right
                    verticalCenter: parent.verticalCenter
                }
                display: AbstractButton.IconOnly
                // icon.source: Qt.resolvedUrl("qrc:/FilesOnSchedule2/icons/forward.svg")
                icon.source: Qt.resolvedUrl("qrc:/FilesOnSchedule2/icons/forward_filled.svg")
                icon.height: height * 0.35
                icon.width: width * 0.35
                onClicked: {
                    WeekEvents.nextWeek();

                    // refresh loader
                    scheduleLoader.sourceComponent = null
                    scheduleLoader.sourceComponent = listViewComponent

                }
            }
        }

        ToolButton{
            id: addEventButton
            anchors{
                right: parent.right
                verticalCenter: parent.verticalCenter
            }
            display: AbstractButton.IconOnly
            // icon.source: Qt.resolvedUrl("qrc:/FilesOnSchedule2/icons/plus_math.svg")
            icon.source: Qt.resolvedUrl("qrc:/FilesOnSchedule2/icons/plus_math_filled.svg")
            icon.height: height * 0.45
            icon.width: width * 0.45
            onClicked: {
                mainStackView.push(Qt.resolvedUrl("AddEvent.qml"))
            }
        }
    }

    Rectangle{
        anchors{
            top: toolBarHeader.bottom
            left: parent.left
            right: parent.right
            bottom: parent.bottom
        }
        color: Qt.rgba(0.2, 0.2, 0.2, 1.0)

        Item{
            id: scheduleHeader
            anchors{
                top: parent.top
                left: parent.left
                leftMargin: labelsArea.width
                right: parent.right
            }
            height: parent.height * 0.05

            ListView{
                anchors.fill: parent
                orientation: Qt.Horizontal
                interactive: false
                clip: true
                model: [
                    {weekDay: "Monday"},
                    {weekDay: "Tuesday"},
                    {weekDay: "Wednesday"},
                    {weekDay: "Thursday"},
                    {weekDay: "Friday"},
                    {weekDay: "Saturday"},
                    {weekDay: "Sunday"},
                ]

                delegate: Item{
                    width: scheduleHeader.width /7
                    height: scheduleHeader.height
                    Label{
                        anchors.centerIn: parent
                        text: modelData.weekDay
                        horizontalAlignment: Qt.AlignHCenter
                        verticalAlignment: Qt.AlignVCenter
                        font.bold: true
                    }
                }
            }

        }

        Item{
            id: labelsArea
            anchors{
                top: scheduleHeader.bottom
                left: parent.left
                bottom: parent.bottom
            }
            width: parent.width / (7*3+1)
        }

        Loader{
            id: scheduleLoader
            anchors{
                top: scheduleHeader.bottom
                left: labelsArea.right
                right: parent.right
                bottom: parent.bottom
            }

            sourceComponent: listViewComponent
        }

        Component{
            id: listViewComponent
            ListView{
                id: listView
                interactive: false
                orientation: Qt.Horizontal
                model: 7
                clip: true
                delegate: Item{
                    width: listView.width /7
                    height: listView.height

                    DayList{
                        anchors.fill: parent
                        dayDate: WeekEvents.getTextDate(index)

                    }

                    // Text{
                    //     anchors.centerIn: parent
                    //     text: index
                    // }
                }
            }

        }

    }

}
