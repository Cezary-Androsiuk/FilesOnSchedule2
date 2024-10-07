import QtQuick 2.15
import QtQuick.Controls.Material

Item {
    id: selectDateTime

    property string dateValue: ""
    property string timeValue: ""
    required property string text

    Label{
        id: label
        anchors{
            left: parent.left
            leftMargin: 8
            top: parent.top
            bottom: parent.bottom
        }

        text: selectDateTime.text
        opacity: 0.7
        font.pixelSize: 26
        elide: Label.ElideRight
        horizontalAlignment: Qt.AlignHCenter
        verticalAlignment: Qt.AlignVCenter

    }

    Item{
        anchors{
            left: parent.left
            leftMargin: 100
            top: parent.top
            bottom: parent.bottom
        }
        width: parent.width /2

        TextField{
            id: dateField
            anchors{
                left: parent.left
                verticalCenter: parent.verticalCenter
            }
            width: parent.width * 3/5 - 10
            placeholderText: "DD-MM-YYYY"
            text: dateValue
            onTextChanged: {
                dateValue = text
            }
        }

        TextField{
            id: timeField
            anchors{
                right: parent.right
                verticalCenter: parent.verticalCenter
            }
            width: parent.width * 2/5
            placeholderText: "HH:MM"
            text: timeValue
            onTextChanged: {
                timeValue = text
            }
        }
    }
}
