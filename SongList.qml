import QtQuick
import Qt.labs.folderlistmodel
import QtQuick.Controls
import Qt5Compat.GraphicalEffects
Rectangle{
    property alias smallimage: photo.source
    property alias bigimage: background.source
    property alias name: name.text
    property alias album: album.text
    property alias artist: artist.text

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
    }
    //虚化效果
    FastBlur{
        anchors.fill: background
        source:background
        radius: 32
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
    //歌词显示
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
                anchors.leftMargin: 80
                font.pixelSize: 13
                font.family:"Microsoft YaHei"
            }
            //歌曲作者显示
            Label{
                id:lyricegenre
                text: "类型："
                Text{
                    id:genre
                    anchors.left: lyricegenre.right
                    font.pixelSize: 13

                    font.family:"Microsoft YaHei"
                }
                anchors.top: lyricsname.bottom
                anchors.topMargin: 30
                anchors.left: lyricsartist.right
                anchors.leftMargin: 80
                font.pixelSize: 13
                font.family:"Microsoft YaHei"
            }
        }
        //歌曲歌词显示
        Rectangle{
            id:lyricsrect
            width: parent.width
            height: 350
            anchors.top: lyricsinformation.bottom
            anchors.topMargin: 30
            color:"transparent"
            ListView{
                id:lyricsview
                anchors.fill: lyricsrect
                model: lyricsmodel
                delegate: delegate
                highlightRangeMode: ListView.StrictlyEnforceRange
                preferredHighlightBegin: lyricsrect.width/2
                preferredHighlightEnd: lyricsrect.height/2
                spacing: 25
            }
            ListModel{
                id:lyricsmodel
                ListElement {
                    name: "Bill Jones"
                }
                ListElement {
                    name: "Jane Doe"
                }
                ListElement {
                    name: "John Smith"
                }
                ListElement {
                    name: "Bill Jones"
                }
                ListElement {
                    name: "Jane Doe"
                }
                ListElement {
                    name: "John Smith"
                }
                ListElement {
                    name: "Bill Jones"
                }
                ListElement {
                    name: "Jane Doe"
                }
                ListElement {
                    name: "John Smith"
                }
            }
            Component{
                id:delegate
                Text {
                    opacity: ListView.isCurrentItem ? 1 : 0.5
                    id: lyricsColumnText
                    text: name
                    font.pointSize: 17
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                    anchors.horizontalCenter: parent.horizontalCenter
                }
            }
        }
    }
}
