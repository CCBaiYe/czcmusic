import QtQuick 2.0
import QtQuick.Controls
import QtMultimedia
Item{
    property  alias ul:sliderControl.value
    Rectangle{
        id: rectangle1
        anchors{
            fill: parent
            topMargin: 5*dp
            bottomMargin: 10*dp
        }

        MusicControlBtn{
            id:currentListBtn
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 0
            anchors.top: parent.top
            anchors.topMargin: 0
            anchors.left: parent.left
            anchors.leftMargin: 0
            width: height
            text:"\uf027"
            MouseArea{
                anchors.fill: parent
                cursorShape: Qt.PointingHandCursor;
                onClicked:{
                    switch(mdp.audioout.muted){
                    case true:{
                        mdp.audioout.muted=false;
                        currentListBtn.text="\uf026";
                        break;
                    }
                    case false:{
                        mdp.audioout.muted=true;
                        currentListBtn.text="\uf027"
                        break;
                    }
                    }
                }
            }
        }

        Slider {
            id: sliderControl;
            value:0.5
            z:1
            onValueChanged: {
                mdp.audioout.volume=value
            }
            anchors{
                left: currentListBtn.right
                leftMargin: 8*dp
                right: parent.right
                verticalCenter: parent.verticalCenter
            }
            background: Rectangle {
                x: sliderControl.leftPadding
                y: sliderControl.topPadding + sliderControl.availableHeight / 2 - height / 2
                implicitHeight: 3*dp;
                width: sliderControl.availableWidth
                height: implicitHeight
                radius: 3*dp;
                color: "#999999"

                Rectangle {
                    width: sliderControl.visualPosition * parent.width
                    height: parent.height
                    color: "#b82525"
                    radius: 3*dp;
                }
                MouseArea{
                    anchors.fill: parent
                    cursorShape: Qt.PointingHandCursor;
                }
            }
            handle: Rectangle {
                x: sliderControl.leftPadding + sliderControl.visualPosition * (sliderControl.availableWidth - width)
                y: sliderControl.topPadding + sliderControl.availableHeight / 2 - height / 2
                width: 10*dp;
                height: 10*dp;
                radius: 10*dp;
                color: "#f6f6f6"

                Label{
                    id:cd;
                    anchors.verticalCenter: parent.verticalCenter;
                    anchors.horizontalCenter: parent.horizontalCenter;
                    text: "\uf192";
                    color: "#b82525";
                    verticalAlignment: Text.AlignVCenter
                    horizontalAlignment: Text.AlignHCenter;
                    font.pixelSize: 10*dp;
                }
            }
        }

    }
}
