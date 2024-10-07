import QtQuick 2.15
import QtQuick.Controls.Material

Item {
    id: dayList

    required property var dayDate

    function timeFromIndex(index){
        var hour = index>9 ? index : ("0"+index)
        return hour + ":00"
    }

    ListView{
        id: listView
        anchors.fill: parent
        // interactive: false
        model: 24
        boundsBehavior: Flickable.StopAtBounds
        clip: true
        delegate: Item{
            height: listView.height / 24
            width: listView.width

            Label{
                anchors.centerIn: parent
                text: dayDate + " " + timeFromIndex(index)
            }

            MouseArea{
                anchors.fill: parent
                onClicked:{
                    mainStackView.push(
                                Qt.resolvedUrl("AddEvent.qml"),
                                {
                                    "dateFrom": dayDate,
                                    "timeFrom": timeFromIndex(index),
                                    "dateTo": dayDate,
                                    "timeTo": timeFromIndex(index+1),
                                })
                }
            }
        }
    }
}
