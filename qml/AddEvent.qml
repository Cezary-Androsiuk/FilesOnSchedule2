import QtQuick 2.15
import QtQuick.Layouts
import QtQuick.Controls.Material

import "components"

Item {
    id: addEvent

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

    property string titleValue: ""
    property string descriptionValue: ""
    property string pathValue: ""
    property int pathSelection: 0 // 0 - none, 1 - file, 2 - folder
    property string dateFrom: ""
    property string timeFrom: ""
    property string dateTo: ""
    property string timeTo: ""

    Item{
        anchors{
            top: toolBarHeader.bottom
            left: parent.left
            right: parent.right
            bottom: parent.bottom
        }

        Item{
            id: loseFocus
            anchors.fill: parent
            MouseArea{
                anchors.fill: parent
                onClicked: loseFocus.focus = true
            }
        }

        Item{
            id: align
            anchors{
                top: parent.top
                horizontalCenter: parent.horizontalCenter
            }

            width: parent.width < 800 ? parent.width : 800
            height: parent.height

            TextField{
                id: titleField
                anchors{
                    top: parent.top
                    horizontalCenter: parent.horizontalCenter
                    topMargin: 30
                }

                placeholderText: "Title"
                text: titleValue
                onTextChanged: {
                    titleValue = text
                }
                width: parent.width * 0.8
            }

            TextArea{
                id: descriptionField
                anchors{
                    top: titleField.bottom
                    horizontalCenter: parent.horizontalCenter
                    topMargin: 30
                }

                placeholderText: "Description"
                text: descriptionValue
                onTextChanged: {
                    descriptionValue = text
                }
                width: parent.width * 0.8
            }

            SelectPathField{
                id: selectPathField
                anchors{
                    top: descriptionField.bottom
                    horizontalCenter: parent.horizontalCenter
                    topMargin: 30
                }

                width: parent.width * 0.8
                height: titleField.height * 1.2
            }

            SelectDateTime{
                id: selectFromDate
                anchors{
                    top: selectPathField.bottom
                    horizontalCenter: parent.horizontalCenter
                    topMargin: 30
                }

                width: parent.width * 0.8
                height: titleField.height

                text: "From"
                dateValue: dateFrom
                onDateValueChanged: dateFrom = dateValue
                timeValue: timeFrom
                onTimeValueChanged: timeFrom = timeValue
            }

            SelectDateTime{
                id: selectToDate
                anchors{
                    top: selectFromDate.bottom
                    horizontalCenter: parent.horizontalCenter
                    topMargin: 30
                }

                width: parent.width * 0.8
                height: titleField.height


                text: "To"
                dateValue: dateTo
                onDateValueChanged: dateTo = dateValue
                timeValue: timeTo
                onTimeValueChanged: timeTo = timeValue

            }

            Item{
                id: submitArea
                anchors{
                    top: selectToDate.bottom
                    horizontalCenter: parent.horizontalCenter
                    topMargin: 30
                }

                width: parent.width * 0.8
                height: titleField.height

                Button{
                    anchors{
                        right: parent.right
                        rightMargin: 30
                        verticalCenter: parent.verticalCenter
                    }
                    text: "Save"

                    onClicked: {
                        console.log("titleValue: " + titleValue)
                        console.log("descriptionValue: " + descriptionValue)
                        console.log("pathValue: " + pathValue)
                        console.log("dateFrom: " + dateFrom)
                        console.log("timeFrom: " + timeFrom)
                        console.log("dateTo: " + dateTo)
                        console.log("timeTo: " + timeTo)
                    }
                }
            }



        }

    }
}
