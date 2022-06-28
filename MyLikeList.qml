import QtQuick
import SongList 1.0
import QtQuick.Controls
Item {
    id:likelistroot
    width: parent.width
    height: parent.height
    ListView{
        id:likelist
        width: parent.width
        height: parent.height
        model: listmodel
        delegate: dele
    }
    Component{
        id:dele
        Row{
            spacing: 20
            Text{text:songName;font.pixelSize: 13}
            Text{text:songArtist;font.pixelSize: 13}
            Text{text:songAlbum;font.pixelSize: 13}
            Text{text:songTime;font.pixelSize: 13}
        }
    }

    SongList{
        id:listmodel
    }
}
