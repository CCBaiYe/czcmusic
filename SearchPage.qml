import QtQuick
import QtQuick.Controls
import OnlineSong

Rectangle{
    property alias online: online
    property alias searchmodel: searchmodel
    id:searchpage
    width: parent.width
    height: parent.height
    Label{
        id:symbolText_
        anchors.top: parent.top
        width: parent.width
        height: 30
        text: ""
        font.pixelSize: 15
        Label{
            id:tec1
            Text{
                text: "标题"
                anchors.left: tec1.left

            }
            anchors.left: symbolText_.left
            anchors.top: symbolText_.top
            anchors.topMargin: 2
            anchors.leftMargin: 60
            font.pixelSize: 15;
        }
        Label{
            id:tec2
            Text{
                text: "歌手"
                anchors.left: tec2.left

            }
            anchors.left: tec1.right
            anchors.top: symbolText_.top
            anchors.topMargin: 2
            anchors.leftMargin: 220
            font.pixelSize: 15;
        }
        Label{
            id:tec3
            Text{
                text: "专辑"
                anchors.left: tec3.left

            }
            anchors.left: tec2.right
            anchors.top: symbolText_.top
            anchors.topMargin: 2
            anchors.leftMargin: 220
            font.pixelSize: 15;
        }
        Label{
            id:tec4
            Text{
                text: "时长"
                anchors.left: tec4.left
            }
            anchors.left: tec3.right
            anchors.top: symbolText_.top
            anchors.topMargin: 2
            anchors.leftMargin: 220
            font.pixelSize: 15;
        }
    }

    //搜索信息显示
    ListView{
        id:searchlist
        anchors.top: symbolText_.bottom
        width: searchpage.width
        height: searchpage.height-30
        model: searchmodel
        delegate: searchDelegate
    }
    Component{
        id:searchDelegate

        SearchPageBtn{
            count: Count;title: Title;artist: Artist;album: Album;time: Time

            TapHandler{
                id:tap2
                acceptedButtons: Qt.LeftButton
                onTapped: {
                    searchlist.currentIndex=index

                }
                onDoubleTapped: {
                    play1.triggered()

                }
            }
            TapHandler{
                id:tap1
                acceptedButtons: Qt.RightButton
                onTapped:  {
                    menu1.popup()
                }
            }

            Menu{
                id:menu1
                Action{
                    id:pause1
                    text: qsTr("暂停")
                    icon.name: "media-playback-pause"
                    onTriggered: mdp.desktoppausebtn()

                }
                Action{
                    id:play1
                    text: qsTr("播放")


                    icon.name: "media-playback-start"
                    onTriggered: {
                        online.getInformation(searchlist.currentIndex)
                    }

                }
                Action{
                    id:addlove
                    text: qsTr("收藏")
                    icon.name: "list-add"
                    onTriggered: {


                        songplaylist.inSert(songplaylist.tableNames[0],online.songName[searchlist.currentIndex],"online.url",online.singerName[searchlist.currentIndex],online.albumName[searchlist.currentIndex],online.turnTime(online.duration[searchlist.currentIndex]));
                        songplaylistmodel.append({"Title":online.songName[searchlist.currentIndex],"Artist":online.singerName[searchlist.currentIndex],"Album":online.albumName[searchlist.currentIndex],"Time":online.turnTime(online.duration[searchlist.currentIndex])})

                    }
                }
                Menu{
                    id:down
                    title: qsTr("下载")
                    Action{
                        id:downsong
                        text: qsTr("歌曲")
                        onTriggered: {
                            online.downLoadsong(searchlist.currentIndex);
                        }
                    }
                    Action{
                        id:downlrc
                        text: qsTr("歌词")
                        onTriggered: {
                            online.downLoadLyrics(searchlist.currentIndex);
                        }
                    }
                }
            }
        }

    }






    ListModel{
        id:searchmodel
    }
    OnlineSong{
        id:online
        property bool netflag:false
        onSongNameChanged: {
            addsong()
        }
        onUrlChanged: {


            mdp.mdplayer.stop()
            mdp.mdplayer.source=online.url
            mdp.desktopbtncontrol()

            footer.songlist.smallimage=online.image
            footer.songlist.bigimage=online.image
            footer.footimage.source=online.image

            footer.palyslider.musicName=online.songName[searchlist.currentIndex]
            footer.songlist.name=online.songName[searchlist.currentIndex]
            footer.songlist.album=online.albumName[searchlist.currentIndex]
            footer.songlist.artist=online.singerName[searchlist.currentIndex]



        }
        onLyricsChanged: {
            netflag=true
        }

        function addsong(){
            searchmodel.clear()
            for(var i=0;i<songName.length;i++)
                searchmodel.append({"Count":searchmodel.count+1,"Title":online.songName[i],"Artist":online.singerName[i],"Album":online.albumName[i],"Time":turnTime(online.duration[i])})
        }
        function turnTime(time){
            //将时间秒转换成分秒
            var m=(parseInt(time/60))
            var s=parseInt(time%60)
            if(s<10&&m<10)
                return "0"+m+":"+"0"+s
            if(s>10&&m<10)
                return "0"+m+":"+s
            if(s<10&&m>10)
                return m+":"+"0"+s
            if(s>10&&m>10)
                return m+":"+s
        }

    }

}
