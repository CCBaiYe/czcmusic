import QtQuick
import QtQuick.Controls
import QtQuick.Layouts


ApplicationWindow{
    property point clickpos: "0,0"
    id:desktop
    minimumWidth: 700
    minimumHeight: 200
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
                desktop.x=ka.x+delta.x
                desktop.y=ka.y+delta.y
            }
    }


    HoverHandler{
        id:hoverHandler
        onHoveredChanged: {
            if(hovered){
                toolbtn.opacity =1
                toolbtn.visible=true
                desktop.color = Qt.rgba(0.5,0.5,0.5,0)
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

            }
            ToolButton{
                id:pausebtn
                text: "\uf04b"
                font.family: "FontAwesome"
                font.pixelSize: 20
                onClicked: {
                    playbtn.visible=true
                    pausebtn.visible=false

                }
            }
            ToolButton{
                id:playbtn
                text:"\uf04c"
                visible: false
                font.family: "FontAwesome"
                font.pixelSize: 20
                onClicked: {
                    pausebtn.visible=true
                    playbtn.visible=false
                }
            }

            ToolButton{
                id:nextbtn
                text: "\uf051"
                font.family: "FontAwesome"
                font.pixelSize: 20
            }
            ToolButton{
                id:lockbtn
                text: "\uf023"
                font.family: "FontAwesome"
                font.pixelSize: 20
                onClicked: {
//                    unlockbtn.visible=true
//                    lockbtn.visible=false
//                    nextbtn.visible=false
//                    pausebtn.visible=false
//                    prebtn.visible=false
//                    closebtn.visible=false
//                    playbtn.visible=false
                    hoverHandler.enabled=false

                }
            }
                ToolButton{
                    id:unlockbtn
                    text: "\uf3c1"
                    visible: false
                    font.family: "FontAwesome"
                    font.pixelSize: 20
                    onClicked: {
                        unlockbtn.visible=false
                        lockbtn.visible=true
                        nextbtn.visible=true
//                        if(pausebtn.visible==true)
//                            pausebtn.visible=true
//                        else pausebtn.visible=false
//                        if(playbtn.visible)
//                            playbtn.visible=true
//                        else playbtn.visible=false
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
                    ka.close()
                }
            }
        }
        Label{
            id:lineLrc
            text: qsTr("no lyrics")
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            Layout.alignment: Qt.AlignVCenter
            font.pixelSize: 30

        }


    }



}
