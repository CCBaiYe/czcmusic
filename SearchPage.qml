import QtQuick
import QtQuick.Controls
import QtQuick.Dialogs
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
                text: qsTr("Title")
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
                text: qsTr("Singer")
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
                text: qsTr("Album")
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
                text: qsTr("Duration")
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
                    searchlist.currentIndex=index
                    menu1.popup()
                    searchlist.currentIndex=index;
                }
            }

            Menu{
                id:menu1
                Action{
                    id:pause1
                    text: qsTr("Pause")
                    icon.name: "media-playback-pause"
                    onTriggered: mdp.desktoppausebtn()

                }
                Action{
                    id:play1
                    text: qsTr("Play")
                    icon.name: "media-playback-start"
                    onTriggered: {
                        online.getInformation(searchlist.currentIndex)
                    }

                }
                Action{
                    id:addlove
                    text: qsTr("Like")
                    icon.name: "list-add"
                    onTriggered: {

                        online.kpSong(searchlist.currentIndex)
                        input.open()

                    }
                }


                Menu{
                    id:down
                    title: qsTr("Download")
                    Action{
                        id:downsong
                        text: qsTr("song")
                        onTriggered: {
                            online.downLoadsong(searchlist.currentIndex);
                            var data={"songName":online.songName[searchlist.currentIndex],
                                "songArtist":online.singerName[searchlist.currentIndex],
                            "songAlbum":online.albumName[searchlist.currentIndex],
                            "songTime":online.turnTime(online.duration[searchlist.currentIndex]),
                            "Count":dialogs.loadmodel.count+1,
                             "songPath":online.songSavePath
                            }
                            //console.log(online.songSavePath)
                            dialogs.loadmodel.append(data);
                        }
                    }
                    Action{
                        id:downlrc
                        text: qsTr("lyr")
                        onTriggered: {
                            online.downLoadLyrics(searchlist.currentIndex);
                        }
                    }
                }
            }
        }
    }
    ListModel{
        id:loadmodel
    }

    Popup{
        id:input
        x:150
        y:200
        width: 200
        height: 40
        TextField{
            id: inputtext
            anchors.fill: parent
            width: parent.width
            height: parent.height
            font.pixelSize: 13
            placeholderText: qsTr("please input playlist name");
            selectByMouse: true
            verticalAlignment: Text.AlignVCenter
            Keys.onPressed: event=>{
                                if(event.key===Qt.Key_Return)
                                {
                                    var songlistname=inputtext.text;
                                    online.kpSong(searchlist.currentIndex)

                                    if(db.isTableExist(songlistname)){
                                        db.insert(songlistname,online.songName[searchlist.currentIndex],online.url,online.singerName[searchlist.currentIndex],online.albumName[searchlist.currentIndex],online.turnTime(online.duration[searchlist.currentIndex]))
                                        songplaylistmodel.append({"Title":online.songName[searchlist.currentIndex],"Artist":online.singerName[searchlist.currentIndex],"Album":online.albumName[searchlist.currentIndex],"Time":online.turnTime(online.duration[searchlist.currentIndex]),"path":online.url})
                                    }else{
                                        messageDialog.open()
                                        console.log("don't have this songlist")
                                    }
                                    input.close();
                                }
            }
        }
    }

    MessageDialog{
        id:messageDialog
        title: qsTr("error input")
        buttons: MessageDialog.Ok
        text: qsTr("Please choose already exist songlist.")

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

            //歌曲加入到播放列表
            if(!(dialogs.fileDialog.isexist(online.url)))
            {
                var data={"Count":dialogs.listM.count+1,
                    "fileName":online.songName[searchlist.currentIndex],
                    "filePath":Qt.resolvedUrl(online.url),
                    "fileTime":online.turnTime(online.duration[searchlist.currentIndex]),
                    "fileAlbum":online.albumName[searchlist.currentIndex],
                    "fileArtist":online.singerName[searchlist.currentIndex]
                }
                dialogs.listM.append(data);
            }

            loadFromFile.writeData(online.songName[searchlist.currentIndex],
                                   Qt.resolvedUrl(online.url),
                                   online.singerName[searchlist.currentIndex],
                                   online.albumName[searchlist.currentIndex],
                                   online.turnTime(online.duration[searchlist.currentIndex]))

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
