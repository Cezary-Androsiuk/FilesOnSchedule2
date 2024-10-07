import QtQuick 2.15
import QtQuick.Dialogs
import QtQuick.Controls.Material

Item{
    id: selectPathField

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
