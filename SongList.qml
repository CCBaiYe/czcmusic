import QtQuick
import Qt.labs.folderlistmodel
import QtQuick.Controls
import Qt5Compat.GraphicalEffects
import LyrInfo 1.0
Rectangle{
    property alias smallimage: photo.source
    property alias bigimage: background.source
    property alias name: name.text
    property alias album: album.text
    property alias artist: artist.text
    property alias fileLyr: fileLyr
    property alias lyrModel: lyrModel

    id:songlistroot
    width: parent.width
    height: parent.height



    //背景图片
    Image {
        id: background
        width: rootwidth
        height: splitviewheiht
        source: "./images/5.png"
        fillMode: Image.Stretch
        //opacity: 0.3
    }
    //虚化效果
    FastBlur{
        anchors.fill: background
        source:background
        radius: 64
    }
    //关闭歌词页面
    Rectangle{
        id:exitpage
        width: 30
        height: 30
        anchors.right: songlistroot.right
        anchors.top: songlistroot.top
        anchors.rightMargin: 20
        anchors.topMargin: 20
        color: "gainsboro"
        //透明度
        opacity: 0.3
        Label{
            id:exit
            font.family: "FontAwesome"
            text: "\uf066"
            font.pixelSize: 20
            anchors.verticalCenter: exitpage.verticalCenter
            anchors.horizontalCenter: exitpage.horizontalCenter
        }
        TapHandler{
            cursorShape: Qt.PointingHandCursor;
            onTapped: {
                songlist.visible=!songlist.visible
            }
        }
    }
    //歌曲图片
    Rectangle{
        id:songimage
        width: 300
        height: 300
        anchors.left: songlistroot.left
        anchors.leftMargin: 150
        anchors.top: songlistroot.top
        anchors.topMargin: 50
        Image {
            id: photo
            width: parent.width
            height: parent.height
            source: "./images/5.png"
            fillMode: Image.Stretch
        }
    }
    //喜欢按钮
    Rectangle{
        id:likeBtn
        width: 60
        height: 30
        anchors.left: songimage.left
        anchors.top: songimage.bottom
        anchors.topMargin: 15
        opacity: 0.7
        radius: 3
        Label{
            id:likeicon
            font.family: "FontAwesome"
            text: "\uf004"
            font.pixelSize: 13
            anchors.verticalCenter: likeBtn.verticalCenter
            anchors.left: likeBtn.left
            anchors.leftMargin: 5

        }
        Label{
            text: "喜欢"
            id:liketext
            font.pixelSize: 13
            anchors.verticalCenter: likeBtn.verticalCenter
            anchors.left: likeicon.right
            anchors.leftMargin: 10
        }
    }
    //收藏按钮
    Rectangle{
        id:colectBtn
        width: 60
        height: 30
        anchors.left: likeBtn.right
        anchors.leftMargin: 20
        anchors.top: songimage.bottom
        anchors.topMargin:15
        radius: 3
        opacity: 0.7
        Label{
            id:colecticon
            text: "\uf0fe"
            font.family: "FontAwesome"
            font.pixelSize: 13
            anchors.verticalCenter: colectBtn.verticalCenter
            anchors.left: colectBtn.left
            anchors.leftMargin: 5
        }

        Label{
            text: "收藏"
            id:colecttext
            font.pixelSize: 13
            anchors.verticalCenter: colectBtn.verticalCenter
            anchors.left: colecticon.right
            anchors.leftMargin: 10
        }

    }
    //下载按钮
    Rectangle{
        id:loadBtn
        width: 60
        height: 30
        anchors.left: colectBtn.right
        anchors.leftMargin: 20
        anchors.top: songimage.bottom
        anchors.topMargin:15
        radius: 3
        opacity: 0.7
        Label{
            id:loadicon
            text: "\uf019"
            font.family: "FontAwesome"
            font.pixelSize: 13
            anchors.verticalCenter: loadBtn.verticalCenter
            anchors.left: loadBtn.left
            anchors.leftMargin: 5
        }
        Label{
            text: "下载"
            id:loadtext
            font.pixelSize: 13
            anchors.verticalCenter: loadBtn.verticalCenter
            anchors.left: loadicon.right
            anchors.leftMargin: 10
        }
    }
    //歌曲基本信息显示
    Rectangle{
        id:lyrics
        width: 350
        height:songlistroot.height
        anchors.left: songimage.right
        anchors.leftMargin: 120
        //透明
        color:"transparent"
        //歌曲信息显示
        Rectangle{
            id:lyricsinformation
            width: lyrics.width
            height: 100
            color:"transparent"
            //歌曲名字显示
            Label{
                id:lyricsname
                text: "名字:"
                Text{
                    id:name
                    anchors.left: lyricsname.right
                    font.pixelSize: 25
                    font.family:"Microsoft YaHei"
                }

                anchors.top: lyricsinformation.top
                anchors.topMargin: 30
                anchors.left: lyricsinformation.left
                anchors.leftMargin: 0
                font.pixelSize: 25
                font.family:"Microsoft YaHei"
            }
            //歌曲专辑显示
            Label{
                id:lyricsalbum
                text: "专辑："
                Text{
                    id:album
                    anchors.left: lyricsalbum.right
                    font.pixelSize: 13

                    font.family:"Microsoft YaHei"
                }
                anchors.top: lyricsname.bottom
                anchors.topMargin: 30
                anchors.left: lyricsinformation.left
                anchors.leftMargin: 5
                font.pixelSize: 13
                font.family:"Microsoft YaHei"
            }
            //歌曲作者显示
            Label{
                id:lyricsartist
                text: "歌手："
                Text{
                    id:artist
                    anchors.left: lyricsartist.right
                    font.pixelSize: 13

                    font.family:"Microsoft YaHei"
                }
                anchors.top: lyricsname.bottom
                anchors.topMargin: 30
                anchors.left: lyricsalbum.right
                anchors.leftMargin: 180
                font.pixelSize: 13
                font.family:"Microsoft YaHei"
            }
        }
        LyrInfo{
            id: fileLyr
            url: footer.palyslider.musicName
            onUrlChanged:{
                lyrModel.clear();
                var taskMap = {},timeMap = {};
                taskMap = fileLyr.lyr;
                timeMap = fileLyr.time;
                for(var key in taskMap){
                    lyrModel.append({'lyrInformation':taskMap[key],'time':timeMap[key]});
                }
            }
            onDurationChanged: index=>{
                                   showLyr.currentIndex = index;
                                   var taskMap = {};
                                   taskMap = fileLyr.lyr;
                                   //desktopLrc.showlyr = taskMap[index]

                                   console.log(taskMap[index])

                               }
        }
        ListModel {
            id: lyrModel
        }

        //歌词显示
        ListView {
            z:10
            id: showLyr
            width: lyrics.width
            height: 275
            anchors.top: lyricsinformation.bottom
            anchors.topMargin: 50
            anchors.left: lyrics.left
            anchors.right: lyrics.right
            model: lyrModel
            focus: true
            delegate: Text{
                width: 350
                font.pixelSize:ListView.isCurrentItem ? 30 : 20
                color: ListView.isCurrentItem ? "red" : "black"
                text: lyrInformation
                //自动换行
                wrapMode: Text.WordWrap
                //行间距
                lineHeight: 0.7
                //水平居中
                horizontalAlignment: Text.AlignHCenter
                //垂直居中
                verticalAlignment: Text.AlignVCenter
                TapHandler{
                    onTapped: {
                        showLyr.currentIndex = index
                        mdp.mdplayer.position = fileLyr.time[index];
                    }
                }
            }
        }
    }
}
