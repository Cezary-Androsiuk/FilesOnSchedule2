import QtQuick 2.15
import QtQuick.Layouts
import QtQuick.Dialogs
import QtQuick.Controls.Material

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

    // property var elements: [
    //     {"fieldName": "Title",          "fieldType": "textarea",    "value": ""},
    //     {"fieldName": "Description",    "fieldType": "textarea",    "value": ""},
    //     {"fieldName": "Path",           "fieldType": "selectpath",  "value": ""},
    //     // {"fieldName": "Day",            "fieldType": "selectday"},
    //     // {"fieldName": "From",           "fieldType": "selecttime"},
    //     // {"fieldName": "To",             "fieldType": "selecttime"},
    //     {"fieldName": "From",           "fieldType": "selectdate",  "value": ""},
    //     {"fieldName": "To",             "fieldType": "selectdate",  "value": ""},
    // ]

    // // "title          TEXT        NOT NULL,"
    // // "description    TEXT        NOT NULL,"
    // // "path           TEXT        NOT NULL,"
    // // "begin_time     INTEGER     NOT NULL,"
    // // "end_time       INTEGER     NOT NULL,"

    // ListView{
    //     id: listView
    //     anchors{
    //         top: toolBarHeader.bottom
    //         left: parent.left
    //         right: parent.right
    //         bottom: parent.bottom
    //     }
    //     // interactive: false
    //     model: elements
    //     boundsBehavior: Flickable.StopAtBounds
    //     clip: true
    //     delegate: Loader{
    //         height: 30
    //         width: listView.width

    //         Text{
    //             anchors.centerIn: parent
    //             text: index
    //         }

    //     }

    // }

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
            // Rectangle{
            //     anchors.fill: parent
            //     color: "red"
            // }

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
                onTextChanged: {
                    descriptionValue = text
                }
                width: parent.width * 0.8
            }

            Item{
                id: selectPathField
                anchors{
                    top: descriptionField.bottom
                    horizontalCenter: parent.horizontalCenter
                    topMargin: 30
                }

                width: parent.width * 0.8
                height: titleField.height * 1.2

                FileDialog{
                    id: fileDialog
                    title: "Select File"

                    onAccepted: {
                        pathValue = fileDialog.selectedFile;
                        pathValue = pathValue.replace("file:///", "")
                        pathSelection = 1;
                    }
                }

                FolderDialog{
                    id: folderDialog
                    title: "Select Folder"

                    onAccepted: {
                        pathValue = folderDialog.selectedFolder;
                        pathValue = pathValue.replace("file:///", "")
                        pathSelection = 2;
                    }
                }

                TabButton{
                    id: selectFileButton
                    anchors{
                        left: parent.left
                        top: parent.top
                        bottom: parent.bottom
                    }
                    width: height
                    display: AbstractButton.IconOnly
                    // icon.source: Qt.resolvedUrl("qrc:/FilesOnSchedule2/icons/file.svg")
                    icon.source: Qt.resolvedUrl("qrc:/FilesOnSchedule2/icons/file_filled.svg")
                    icon.height: height * 0.4
                    icon.width: width * 0.4

                    checkable: false
                    checked: pathSelection == 1

                    onClicked: {
                        fileDialog.open()
                    }
                }

                TabButton{
                    id: selectFolderButton
                    anchors{
                        left: selectFileButton.right
                        top: parent.top
                        bottom: parent.bottom
                    }
                    width: height
                    display: AbstractButton.IconOnly
                    // icon.source: Qt.resolvedUrl("qrc:/FilesOnSchedule2/icons/opened_folder.svg")
                    icon.source: Qt.resolvedUrl("qrc:/FilesOnSchedule2/icons/opened_folder_filled.svg")
                    icon.height: height * 0.4
                    icon.width: width * 0.4

                    checkable: false
                    checked: pathSelection == 2

                    onClicked: {
                        folderDialog.open();
                    }
                }

                Label{
                    id: pathLabel
                    anchors{
                        top: parent.top
                        left: selectFolderButton.right
                        leftMargin: selectFolderButton.width/3
                        right: parent.right
                        bottom: parent.bottom
                    }

                    // elide: Text.ElideRight
                    wrapMode: Text.WrapAnywhere
                    font.pixelSize: 16
                    horizontalAlignment: Text.AlignLeft
                    verticalAlignment: Text.AlignVCenter

                    text: pathValue
                }


            }

            Item{
                id: selectFrom
                anchors{
                    top: selectPathField.bottom
                    horizontalCenter: parent.horizontalCenter
                    topMargin: 30
                }

                width: parent.width * 0.8
                height: titleField.height


                Label{
                    id: fromLabel
                    anchors{
                        left: parent.left
                        leftMargin: 8
                        top: parent.top
                        bottom: parent.bottom
                    }

                    text: "From"
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
                        id: fromFieldDate
                        anchors{
                            left: parent.left
                            verticalCenter: parent.verticalCenter
                        }
                        width: parent.width * 3/5 - 10
                        placeholderText: "DD-MM-YYYY"
                        onTextChanged: {
                            timeFrom = text
                        }
                    }

                    TextField{
                        id: fromFieldTime
                        anchors{
                            right: parent.right
                            verticalCenter: parent.verticalCenter
                        }
                        width: parent.width * 2/5
                        placeholderText: "HH:MM"
                        onTextChanged: {
                            timeTo = text
                        }
                    }
                }

            }

            Item{
                id: selectTo
                anchors{
                    top: selectFrom.bottom
                    horizontalCenter: parent.horizontalCenter
                    topMargin: 30
                }

                width: parent.width * 0.8
                height: titleField.height


                Label{
                    id: toLabel
                    anchors{
                        left: parent.left
                        leftMargin: 8
                        top: parent.top
                        bottom: parent.bottom
                    }

                    text: "To"
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
                        id: toFieldDate
                        anchors{
                            left: parent.left
                            verticalCenter: parent.verticalCenter
                        }
                        width: parent.width * 3/5 - 10
                        placeholderText: "DD-MM-YYYY"
                        onTextChanged: {
                            dateFrom = text
                        }
                    }

                    TextField{
                        id: toFieldTime
                        anchors{
                            right: parent.right
                            verticalCenter: parent.verticalCenter
                        }
                        width: parent.width * 2/5
                        placeholderText: "HH:MM"
                        onTextChanged: {
                            dateTo = text
                        }
                    }
                }

            }

            Item{
                id: submitArea
                anchors{
                    top: selectTo.bottom
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
