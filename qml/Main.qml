import QtQuick
import QtQuick.Controls.Material

Item {
    id: rootItem

    property bool globalVisibleChanger: true

    Connections{
        target: Initializer
        // step 1 failed
        function onApplicationIsAlreadyRunning(){
            // inform user about that
            // exit
            e1.show();
        }

        // step 2 failed
        function onPersonalizationInitializeFailed(){
            // ask user if retry, use/leave default or exit
            // popup will handle cases
            e2.show();
        }

        // step 3 failed
        function onDatabaseInitializeFailed(){
            // ask user if retry or exit
            // popup will handle cases
            e3.show();
        }

        // positive end
        function onInitialized(){
            // make main window visible and other stuff to init
            // mainWindow.showMaximized()
            mainWindow.showNormal()
        }
    }

    MainWindow{
        id: mainWindow
    }

    Error1Window{
        id: e1
    }

    Error2Window{
        id: e2
    }

    Error3Window{
        id: e3
    }

    // focus: true
    // Keys.onPressed: (event) => {
    //     if (event.key === Qt.Key_V && isDebugMode)
    //         root.globalVisibleChanger = !root.globalVisibleChanger
    // }

    // Header{
    //     anchors{
    //         top: parent.top
    //         left: parent.left
    //         right: parent.right
    //     }

    //     height: parent.height * 0.07
    // }
}
