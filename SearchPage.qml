import QtQuick
import QtQuick.Controls

Rectangle{
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
            Count:0
            Title:"标题"
            Artist:"歌手"
            Album:"专辑"
            Time:"时长"
        }
    }
}
