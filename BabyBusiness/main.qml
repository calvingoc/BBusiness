import QtQuick 2.9
import QtQuick.Window 2.2

Window {
    id:window
    visible: true
    width: 640
    height: 480
    title: qsTr("Baby Business")
    color: "#38FBFF"
    property bool momsTurn: settings.momsTurn
    property int radness: 0
    property bool rad: false
    onRadChanged: {
        radAnimation.stop()
        radAnimation.start()
    }

    Image {
        id: title
        source: "./p8q4wmdl.png"
        width: parent.width/1.5
        fillMode: Image.PreserveAspectFit
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: parent.top
        anchors.topMargin: 30
    }
    Image{
        id: radImg
        source: "./rad.png"
        width: title.width/3
        fillMode: Image.PreserveAspectFit
        x: parent.width/2 - width
        y: - height*1.25
        rotation: 15

    }
    Image{
        id: dadImg
        source: "./dad.png"
        width: title.width/3
        fillMode: Image.PreserveAspectFit
        x: parent.width/2
        y:-height*1.25
        rotation: -23

    }

    Image{
        id: mom
        height: parent.height*2/3
        width: parent.width/2
        anchors.bottom: parent.bottom
        anchors.left: parent.left
        anchors.leftMargin: -width*.1
        source: "mom.png"
        fillMode: Image.PreserveAspectCrop
        z:1

        MouseArea{
            anchors.fill: parent
            onDoubleClicked: {
                rad = false;
                radness = 0;
            }
        }
    }
    Image{
        id: dad
        height: parent.height*2/3
        width: parent.width/2
        anchors.bottom: parent.bottom
        anchors.right: parent.right
        source: "mark.png"
        fillMode: Image.PreserveAspectCrop
        z:1
        Image {
            id: glasses
            source: "./Meme_Sunglasses.png"
            opacity: radness * .2
            width: parent.width/2
            mirror: true
            fillMode: Image.PreserveAspectFit
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.horizontalCenterOffset: dad.width*.1
            anchors.top: parent.top
            anchors.topMargin: dad.height*.1
        }

        MouseArea{
            anchors.fill: parent
            onClicked:{
                radness = radness+1
                if (radness > 4){
                    rad=true
                    if (!momsTurn){
                    settings.momsTurn = true;
                    babyThrow.start()
                    }
                }
            }
        }
    }
    Image{
        id:baby
        x: window.width/2 - width/2
        y: parent.height/3
        width: parent.width/3
        height: parent.height/3
        fillMode: Image.PreserveAspectFit
        source: "baby.png"
        MouseArea{
            anchors.fill: parent
            onClicked: {
                settings.momsTurn = !settings.momsTurn
                babyThrow.stop()
                babyThrow.start()

            }
        }
        z:3
    }

    ParallelAnimation{
        id:babyThrow
        onStopped: {
            if (rad && !settings.momsTurn){
                settings.momsTurn = true;
                babyThrow.start()
            }
        }

        NumberAnimation {
            target: baby
            property: "x"
            duration: 1000
            easing.type: Easing.InOutQuad
            to: momsTurn ? window.width/4 - mom.width*.1 : window.width/2 + mom.width*.1
        }

        SequentialAnimation{

            NumberAnimation {
                target: baby
                property: "y"
                duration: 500
                easing.type: Easing.InOutQuad
                to:0
            }
            NumberAnimation {
                target: baby
                property: "y"
                duration: 500
                easing.type: Easing.InOutQuad
                to:window.height/3 *1.1
            }
        }
        SequentialAnimation{

            NumberAnimation {
                target: dad
                property: "opacity"
                duration: 400
                easing.type: Easing.InOutQuad
            }

            NumberAnimation {
                target: baby
                property: "rotation"
                duration: 200
                easing.type: Easing.InOutQuad
                from:0
                to: (rad && momsTurn) ? 360 : 0
            }
        }
    }

    ParallelAnimation{
        id:radAnimation

        NumberAnimation {
            target: radImg
            property: "y"
            duration: rad ? 200 : 500
            easing.type: Easing.InOutQuad
            to: rad ? -radImg.height*1.25  :  (30 + title.height)
        }

        NumberAnimation {
            target: radImg
            property: "rotation"
            duration: rad ? 200 : 500
            easing.type: Easing.InOutQuad
            to: rad ? 15 : 0
        }
        NumberAnimation {
            target: dadImg
            property: "y"
            duration: rad ? 200 : 500
            easing.type: Easing.InOutQuad
            to: rad ? -dadImg.height*1.25 :  (30 + title.height)
        }

        NumberAnimation {
            target: dadImg
            property: "rotation"
            duration: rad ? 200 : 500
            easing.type: Easing.InOutQuad
            to: rad ? -23 : 0
        }
    }

}
