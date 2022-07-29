cmake_minimum_required(VERSION 3.23)

project(ccmusic VERSION 0.1 LANGUAGES CXX)

set(CMAKE_AUTOMOC ON)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

find_package(Qt6 6.2 COMPONENTS Quick REQUIRED)
find_package(Qt6 6.2 REQUIRED COMPONENTS Widgets)
find_package(Qt6 6.2 REQUIRED COMPONENTS Core)
find_package(Qt6 REQUIRED COMPONENTS Multimedia)
find_package(Qt6 REQUIRED COMPONENTS Widgets)
find_package(Qt6 REQUIRED COMPONENTS LinguistTools)


INCLUDE_DIRECTORIES("/usr/include/taglib")

qt_add_executable(appccmusic
    main.cpp
    getinformation.h
    getinformation.cpp
    onlinesong.h
    onlinesong.cpp
    datainitialization.h
    datainitialization.cpp
    lyrinfo.h
    lyrinfo.cpp
    songlist.h
    songlist.cpp
    database.cpp
    database.h
    editlyr.h
    editlyr.cpp
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
              MyLikeList.qml
              DesktopLrc.qml
              LyrEditing.qml
              LoadPage.qml
              LoadPageBtn.qml
              RecentPlayPage.qml
              RecentPlayPageBtn.qml
    RESOURCES
            Font/font-awesome.css
            Font/fontawesome-webfont.ttf
            images/5.png
)



qt6_add_translations(appccmusic
#    TS_FILES main_en.ts
    TS_FILES main_zh_CN.ts
    QM_FILES_OUTPUT_VARIABLE qm_files)







#INCLUDE_DIRECTORIES(${CPPUNIT_INCLUDE_DIR})


target_link_libraries(appccmusic PRIVATE tag Qt6::Quick Qt6::Multimedia Qt6::Widgets)


find_package(Qt6 REQUIRED COMPONENTS Sql)
target_link_libraries(appccmusic PRIVATE Qt6::Sql )


set_target_properties(appccmusic PROPERTIES
    MACOSX_BUNDLE_GUI_IDENTIFIER my.example.com
    MACOSX_BUNDLE_BUNDLE_VERSION ${PROJECT_VERSION}
    MACOSX_BUNDLE_SHORT_VERSION_STRING ${PROJECT_VERSION_MAJOR}.${PROJECT_VERSION_MINOR}
    MACOSX_BUNDLE TRUE
    WIN32_EXECUTABLE TRUE
)

target_compile_definitions(appccmusic
    PRIVATE $<$<OR:$<CONFIG:Debug>,$<CONFIG:RelWithDebInfo>>:QT_QML_DEBUG>)


