QT += quick
QT += multimedia
QT += sql
QT+=widgets
CONFIG += c++17
SOURCES += \
        main.cpp \
        
DISTFILES += \
    CurrentList.qml \
    CurrentListBtn.qml \
    FileD.qml \
    Footerwindow.qml \
    LocaMusicPage.qml \
    Mediaplayer.qml \
    MusicControlBtn.qml \
    MusicRoundButton.qml \
    NavBarBtn.qml \
    NavigationBar.qml \
    PlaySlider.qml \
    VolumnControl.qml

resources.files = main.qml  $$DISTFILES
resources.prefix = /$${TARGET}
RESOURCES += resources

# Additional import path used to resolve QML modules in Qt Creator's code model
QML_IMPORT_PATH =

# Additional import path used to resolve QML modules just for Qt Quick Designer
QML_DESIGNER_IMPORT_PATH =

# Default rules for deployment.
qnx: target.path = /tmp/$${TARGET}/bin
else: unix:!android: target.path = /opt/$${TARGET}/bin
!isEmpty(target.path): INSTALLS += target

HEADERS += \

