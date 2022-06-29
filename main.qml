import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Controls
import GetInformation 1.0
import SongPlayList 1.0
ApplicationWindow {
    id:root
    flags:Qt.FramelessWindowHint | Qt.Window;
    visible: true
    width:1020
    height: 650
    property alias dialogs: dialogs
    property alias rootwidth: root.width
    property alias rootheight: root.height
    property alias navwidth:nav.width
    property alias pageLoader: pageLoader
    property alias pageloaderw: pageLoader.width
    property alias splitviewheiht: splitView.height
    property alias splitView: splitView
    property alias footerheight: footer.height
    property alias getinfor: getinfor
    property alias songplaylist: songplaylist
    property alias nav: nav
    property alias menu: menu
    property real dpScale: 1.5;     //在不同的分辨率屏幕下的窗口伸缩因子
    readonly property real dp: Math.max(Screen.pixelDensity*25.4/160*dpScale);
    header: TitleBar{
        id:menu
        height:parent.height*0.07
        color: "#DC2F2E"
        //实现窗口无边框的拖拽
        MouseArea{
            //防止拖拽事件影响其他鼠标事件
            z:-1
            id: dragRegion2
            anchors.fill: parent
            property point clickPos:"0,0"
            onDoubleClicked: {
                menu.isfullsceen=!menu.isfullsceen
                if(menu.isfullsceen){
                    root.showMaximized();
                }else{
                    root.showNormal();
                }
            }

            onPressed:{
                (mouse)=>{clickPos =Qt.point(
                        mouse.x,mouse.y)}
            }
            onPositionChanged:mouse=>{
                    //鼠标偏移量
                    var delta =Qt.point(mouse.x-clickPos.x, mouse.y-clickPos.y)

                    //改变窗口位置
                    root.x=(root.x+delta.x)
                    root.y=(root.y+delta.y)

            }
        }
    }
    footer: Footerwindow{
        id:footer
        anchors.top: splitView.bottom
        height: root.height*0.07
        width: root.width
    }
    Mediaplayer{
        id:mdp
    }
    FileD {
            id: dialogs
            }
    SplitView {
        id: splitView
        height: root.height-menu.height-footer.height
        anchors.top: menu.bottom
        anchors.fill: parent
        handle: Rectangle {
            implicitWidth: 4
            implicitHeight: 4
            color: SplitHandle.pressed ? "#81e889"
                : (SplitHandle.hovered ? Qt.lighter("#c2f4c6", 1.1) : "#c2f4c6")

            containmentMask: Item {
                x: -width / 2
                width: 64
                height: splitView.height
            }
        }
        NavigationBar{
            id:nav
            width: root.width/3.5
            implicitWidth: 200
            color: "white"
            height: splitView.height
        }
        Item{
            width: root.width-nav.width
            height: splitView.height
            Loader{
                id:pageLoader
                width: root.width-nav.width
                height: splitView.height

            }
            SearchPage{
                id:searchPage
                visible: false
                width: root.width-nav.width
                height: splitView.height
            }
        }
    }
    GetInformation{
        id:getinfor
    }
    SongPlayList{
        id:songplaylist
    }
    ListModel{
        id:songplaylistmodel
    }

    DesktopLrc{
        id:desktopLrc
        visible: false
    }
    Component.onCompleted: {
        //console.log(songplaylist.tableNames.length)
        if(songplaylist.tableNames.length!==0){

            songplaylist.readSongListTables()
            for(var i=0;i<songplaylist.tableNames.length;i++){
                var songlistname=songplaylist.tableNames[i];

                nav.navbarListmodel.append({"type":qsTr("List"),"itemText_":songlistname,
                                           "symbolText_":"\uf0ca","fontfamily_":"Solid","Count":nav.navbarListmodel.count+2})
            }

            songplaylist.querySongDatas(songplaylist.tableNames[0])

            for(var i=0;i<songplaylist.songName.length;i++){
                songplaylistmodel.append({"Title":songplaylist.songName[i],"Artist":songplaylist.songArtist[i],"Album":songplaylist.songAlbum[i],"Time":songplaylist.songTime[i]})
            }


        }

    }

}
