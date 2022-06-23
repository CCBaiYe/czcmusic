import QtQuick
import QtQuick.Controls
import OnlineSong

Rectangle{
    property alias online: online
    id:searchpage
    width: parent.width
    height: parent.height
    //搜索信息显示
    ListView{
        id:searchlist
        width: searchpage.width
        height: searchpage.height
        model: searchmodel
        delegate: SearchPageBtn{count: Count;title: Title;artist: Artist;album: Album;time: Time}
    }
    ListModel{
        id:searchmodel
        ListElement{
            Count:""
            Title:"标题"
            Artist:"歌手"
            Album:"专辑"
            Time:"时长"
        }
    }
    OnlineSong{
        id:online
        property int cnt: 0
        onSongNameChanged: {
            addsong(cnt);
            cnt++;
        }
        onUrlChanged: {
            //console.log(online.image)
            //footer.songlist.smallimage=online.image

        }
        function addsong(num){
            if(num<10){
                searchmodel.append({"Count":"0"+num,"Title":online.songName[num],"Artist":online.singerName[num],"Album":online.albumName[num],"Time":dialogs.fileDialog.setTime(online.duration[num])})
            }else{
                 searchmodel.append({"Count":""+num,"Title":online.songName[num],"Artist":online.singerName[num],"Album":online.albumName[num],"Time":dialogs.fileDialog.setTime(online.duration[num])})
                }

        }

    }
}
