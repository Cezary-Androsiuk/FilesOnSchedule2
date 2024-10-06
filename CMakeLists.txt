cmake_minimum_required(VERSION 3.16)

project(FilesOnSchedule2 VERSION 0.1 LANGUAGES CXX)

set(CMAKE_CXX_STANDARD_REQUIRED ON)

find_package(Qt6 6.4 REQUIRED COMPONENTS Quick Sql)

qt_standard_project_setup()

qt_add_executable(appFilesOnSchedule2
    main.cpp
)

qt_add_qml_module(appFilesOnSchedule2
    URI FilesOnSchedule2
    VERSION 1.0
    QML_FILES
        qml/Main.qml
        QML_FILES qml/Header.qml
        QML_FILES qml/components/VisibleField.qml
        SOURCES cpp/Personalization.h cpp/Personalization.cpp
        SOURCES cpp/Log.h cpp/Log.cpp
        SOURCES cpp/Initializer.h cpp/Initializer.cpp
        SOURCES cpp/Database.h cpp/Database.cpp
        QML_FILES qml/MainWindow.qml
        QML_FILES qml/Error1Window.qml
        QML_FILES qml/Error2Window.qml
        QML_FILES qml/Error3Window.qml
        SOURCES cpp/Event.h cpp/Event.cpp
        SOURCES cpp/WeekEvents.h cpp/WeekEvents.cpp
        QML_FILES qml/MainContent.qml
        QML_FILES qml/AddEvent.qml
        QML_FILES qml/Settings.qml
        QML_FILES qml/DayList.qml

        RESOURCES icons/back.svg
        RESOURCES icons/back_filled.svg
        RESOURCES icons/forward.svg
        RESOURCES icons/forward_filled.svg
        RESOURCES icons/left.svg
        RESOURCES icons/left_filled.svg
        RESOURCES icons/plus_math.svg
        RESOURCES icons/plus_math_filled.svg
        RESOURCES icons/settings.svg
        RESOURCES icons/settings_filled.svg
        RESOURCES icons/file.svg
        RESOURCES icons/file_filled.svg
        RESOURCES icons/opened_folder.svg
        RESOURCES icons/opened_folder_filled.svg
)

# Qt for iOS sets MACOSX_BUNDLE_GUI_IDENTIFIER automatically since Qt 6.1.
# If you are developing for iOS or macOS you should consider setting an
# explicit, fixed bundle identifier manually though.
set_target_properties(appFilesOnSchedule2 PROPERTIES
#    MACOSX_BUNDLE_GUI_IDENTIFIER com.example.appFilesOnSchedule2
    MACOSX_BUNDLE_BUNDLE_VERSION ${PROJECT_VERSION}
    MACOSX_BUNDLE_SHORT_VERSION_STRING ${PROJECT_VERSION_MAJOR}.${PROJECT_VERSION_MINOR}
    MACOSX_BUNDLE TRUE
    WIN32_EXECUTABLE TRUE
)

target_link_libraries(appFilesOnSchedule2
    PRIVATE Qt6::Quick Qt6::Sql
)

include(GNUInstallDirs)
install(TARGETS appFilesOnSchedule2
    BUNDLE DESTINATION .
    LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
    RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}
)
