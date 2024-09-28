import QtQuick
import QtQuick.Controls.Material

ApplicationWindow {
    id: root
    width: 640
    height: 480
    visible: true
    title: qsTr("File on Schedule 2")

    property bool globalVisibleChanger: true

    Connections{
        target: Initializer
        function onInitialized(){
            // make main window visible and other stuff to init
        }

        function onApplicationIsAlreadyRunning(){
            // inform user about that
            // exit
        }

        function onPersonalizationInitializeFailed(){
            // ask user if retry, use/leave default or exit
            // popup will handle cases
        }

        function onDatabaseInitializeFailed(){
            // ask user if retry or exit
            // popup will handle cases
        }
    }


    Item{
        id: rootItem
        anchors.fill: parent

        focus: true
        Keys.onPressed: (event) => {
            if (event.key === Qt.Key_V && isDebugMode)
                root.globalVisibleChanger = !root.globalVisibleChanger
        }

        Header{
            anchors{
                top: parent.top
                left: parent.left
                right: parent.right
            }

            height: parent.height * 0.07
        }
    }


}
