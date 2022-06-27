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
//            spacing: 20
//            Text{text:fileName;font.pixelSize: 13}
//            Text{text:fileArtist;font.pixelSize: 13}
//            Text{text:fileAlbum;font.pixelSize: 13}
//            Text{text:fileTime;font.pixelSize: 13}
        }
    }

    SongList{
        id:listmodel
    }
}
