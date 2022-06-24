cmake_minimum_required(VERSION 3.23)

project(ccmusic VERSION 0.1 LANGUAGES CXX)

set(CMAKE_AUTOMOC ON)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

find_package(Qt6 6.2 COMPONENTS Quick REQUIRED)
find_package(Qt6 6.2 REQUIRED COMPONENTS Widgets)
find_package(Qt6 6.2 REQUIRED COMPONENTS Core)
find_package(Qt6 REQUIRED COMPONENTS Multimedia)



INCLUDE_DIRECTORIES("/usr/include/taglib")



qt_add_executable(appccmusic
    main.cpp
    getinformation.h
    getinformation.cpp
    onlinesong.h
    onlinesong.cpp

)

qt_add_qml_module(appccmusic
    URI ccmusic
    VERSION 1.0
    QML_FILES main.qml

              CurrentList.qml
              CurrentListBtn.qml
              FileD.qml
              FolderListBtn.qml
              Footerwindow.qml
              LocaMusicPage.qml
              Mediaplayer.qml
              MusicControlBtn.qml
              MusicRoundButton.qml
              NavBarBtn.qml
              NavigationBar.qml
              PlaySlider.qml
              SongList.qml
              VolumnControl.qml
              TitleBar.qml
              SearchRect.qml
              SearchPage.qml
              SearchPageBtn.qml
              FunctionalButton.qml
    RESOURCES
            Font/font-awesome.css
            Font/fontawesome-webfont.ttf
            images/5.png
)

#INCLUDE_DIRECTORIES(${CPPUNIT_INCLUDE_DIR})

target_link_libraries(appccmusic PRIVATE tag Qt6::Quick Qt6::Multimedia)



set_target_properties(appccmusic PROPERTIES
    MACOSX_BUNDLE_GUI_IDENTIFIER my.example.com
    MACOSX_BUNDLE_BUNDLE_VERSION ${PROJECT_VERSION}
    MACOSX_BUNDLE_SHORT_VERSION_STRING ${PROJECT_VERSION_MAJOR}.${PROJECT_VERSION_MINOR}
    MACOSX_BUNDLE TRUE
    WIN32_EXECUTABLE TRUE
)

target_compile_definitions(appccmusic
    PRIVATE $<$<OR:$<CONFIG:Debug>,$<CONFIG:RelWithDebInfo>>:QT_QML_DEBUG>)


