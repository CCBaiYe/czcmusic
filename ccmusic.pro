QT += quick
QT += multimedia
QT += sql
QT+=widgets
CONFIG += c++17
SOURCES += \
        getinformation.cpp \
        main.cpp \
         \
        onlinesong.cpp
DISTFILES += \
    CurrentList.qml \
    CurrentListBtn.qml \
    FileD.qml \
    FolderListBtn.qml \
    Font/fontawesome-webfont.ttf \
    Footerwindow.qml \
    LocaMusicPage.qml \
    Mediaplayer.qml \
    MusicControlBtn.qml \
    MusicRoundButton.qml \
    NavBarBtn.qml \
    NavigationBar.qml \
    PlaySlider.qml \
    SongList.qml \
    VolumnControl.qml

resources.files = main.qml  $$DISTFILES
resources.prefix = /$${TARGET}
RESOURCES += resources \
    images.qrc

# Additional import path used to resolve QML modules in Qt Creator's code model
QML_IMPORT_PATH =

# Additional import path used to resolve QML modules just for Qt Quick Designer
QML_DESIGNER_IMPORT_PATH =

# Default rules for deployment.
qnx: target.path = /tmp/$${TARGET}/bin
else: unix:!android: target.path = /opt/$${TARGET}/bin
!isEmpty(target.path): INSTALLS += target

HEADERS += \
    getinformation.h \
    onlinesong.h

unix|win32: LIBS += -ltag

unix|win32: LIBS += -ltag_c

unix|win32: LIBS += -lz

unix|win32: LIBS += -lavutil
unix|win32: LIBS += -lavformat
unix|win32: LIBS += -lavcodec
unix|win32: LIBS += -lswresample
