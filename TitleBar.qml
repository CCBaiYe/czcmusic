import QtQuick
import QtQuick.Controls

Rectangle{
    id:toolbarroot
    //搜索框
    Rectangle{
        id:searchbox
        width: 200
        height: 20
        anchors.left: toolbarroot.left
        anchors.leftMargin: 200
        anchors.verticalCenter: toolbarroot.verticalCenter
        radius: 15
        //关键词输入
        TextField{
            background:Image {
                id: name
            }
            id:searchtext
            anchors.verticalCenter: searchbox.verticalCenter
            verticalAlignment: Text.AlignVCenter
            font.pixelSize: 12
            placeholderTextColor: "lightgrey"
            placeholderText: qsTr("搜索音乐，歌手, 用户");
        }
        TapHandler{
            onTapped: {
                searchdlg.open();
            }
        }
        onActiveFocusChanged: {
            if(activeFocus || searchdlg.activeFocus)
            {
                if(text.length===0){
                    searchdlg.open();
                    console.log("open")
                }
            }
            else{
                searchdlg.close();
                console.log("close")
            }
        }
        Label{
            id:search
            anchors.right:searchbox.right
            anchors.rightMargin:10
            anchors.verticalCenter: searchbox.verticalCenter
            font.family: "FontAwesome"
            font.pixelSize: 12
            text: "\uf002"
            TapHandler{
                onTapped: {
                    pageLoader.source="SearchPage.qml"
                }
            }
        }
        Popup{
            topMargin: toolbarroot.height;
            id:searchdlg;
            //visible: false;
            width: searchbox.width;
            height: 300
            background: Loader{
                source: "SearchRect.qml";
            }
            onClosed: searchbox.focus=false;
        }

    }
    FunctionalButton{
        anchors.right: toolbarroot.right
        anchors.verticalCenter: toolbarroot.verticalCenter
        height: 20

    }
}
