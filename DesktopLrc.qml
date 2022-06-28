import QtQuick
import QtQuick.Controls
import QtQuick.Layouts


ApplicationWindow{
    property point clickpos: "0,0"
    property alias showlyr: lineLrc.text
    property alias pausebtn: pausebtn
    property alias playbtn: playbtn
    property alias closebtn: closebtn
    id:desktop
    minimumWidth: 700
    minimumHeight: 200
    //opacity: 0.5
    flags: Qt.Window|Qt.FramelessWindowHint
    color: Qt.rgba(0,0,0,0)



    MouseArea{
        anchors.fill: parent
        onPressed:
            (mouse)=>{
                clickpos=Qt.point(mouse.x,mouse.y)
            }


        onPositionChanged:
            (mouse)=>{
                //鼠标偏移量
                var delta=Qt.point(mouse.x-clickpos.x,mouse.y-clickpos.y)
                desktop.x=desktop.x+delta.x
                desktop.y=desktop.y+delta.y
            }
    }


    HoverHandler{
        id:hoverHandler
        onHoveredChanged: {
            if(hovered){
                toolbtn.opacity =1
                toolbtn.visible=true
                desktop.color="lightgrey"
            }
            if(!hovered){
                toolbtn.opacity =0
                desktop.color = Qt.rgba(0,0,0,0)
                toolbtn.visible=false
            }
        }

    }


    ColumnLayout{
        anchors.fill: parent
        RowLayout{
            id:toolbtn
            spacing: 20
            Layout.alignment: Qt.AlignHCenter
            ToolButton{
                id:prebtn
                text:"\uf048"
                font.family: "FontAwesome"
                font.pixelSize: 20
                onCanceled: {
                    dialogs.fileDialog.preplay()
                }

            }
            ToolButton{
                id:pausebtn
                text: "\uf04b"
                font.family: "FontAwesome"
                font.pixelSize: 20
                onClicked: {

                    mdp.desktopbtncontrol()

                }
            }
            ToolButton{
                id:playbtn
                text:"\uf04c"
                visible: false
                font.family: "FontAwesome"
                font.pixelSize: 20
                onClicked: {
                    mdp.desktoppausebtn()
                }
            }

            ToolButton{
                id:nextbtn
                text: "\uf051"
                font.family: "FontAwesome"
                font.pixelSize: 20
                onClicked: {
                    dialogs.fileDialog.nextplay()
                }
            }
            ToolButton{
                id:lockbtn
                text: "\uf023"
                font.family: "FontAwesome"
                font.pixelSize: 20
                onClicked: {
                    unlockbtn.visible=true
                    lockbtn.visible=false
                    nextbtn.visible=false
                    pausebtn.visible=false
                    prebtn.visible=false
                    closebtn.visible=false
                    playbtn.visible=false


                }
            }
                ToolButton{
                    id:unlockbtn
                    text: "\uf13e"
                    visible: false
                    font.family: "FontAwesome"
                    font.pixelSize: 20
                    onClicked: {
                        unlockbtn.visible=false
                        lockbtn.visible=true
                        nextbtn.visible=true
                        prebtn.visible=true
                        closebtn.visible=true
                        hoverHandler.enabled=true

                    }
            }
            ToolButton{
                id:closebtn
                text: "\uf00d"
                font.family: "FontAwesome"
                font.pixelSize: 20

                onClicked: {
                    desktop.visible=false

                }
            }
        }
        Text{
            id:lineLrc
            text: qsTr("No Lyrics")
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            Layout.alignment: Qt.AlignHCenter
            font.pixelSize: 35
            wrapMode: Text.WordWrap
            color: "red"

        }


    }



}
