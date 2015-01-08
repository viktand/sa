import QtQuick 2.0
import screenSize 1.0

// корабль и элементы управления к нему

Item {
    id: shipBig
    width: cFun.screenWidth()
    height: cFun.screenHeight()
    x: 0
    y: 0
    property int shX: width/10
    property int shY: height/2
    property bool shVis: false
    property int shWidth: width/10
    property int shHeight: shWidth/3.33
    property bool direct: false
    property double kf: 128/shWidth
    property int poligon: 0

    ScreenFunctions{
        id: cFun
    }

    Image{                      // корабль
        id: ship
        width: shWidth
        height: shHeight
        visible: shVis
        x: shX
        y: shY
        smooth: true
        source: "qrc:/images/ship"
        fillMode: Image.Stretch
    }

    MouseArea{
        id: shut
        width: parent.width/3
        height: parent.height
        x: parent.width-width
        y: 0
        enabled: direct
        onClicked: {
            if(missSh.missVisible==false && missShutCount>0){
               missSh.start()
            }
        }
    }

    MouseArea{
        id: up
        x: 0
        y: 0
        width: parent.width/3
        height: parent.height/2
        enabled: direct
        onPressed: timerUp.start()
        onClicked: timerUp.stop()
        onExited: timerUp.stop()
        onEntered: timerUp.start()
    }

    Timer{  // таймер смещения корабля вверх, при удержании "кнопки"
        id: timerUp
        interval: 50
        repeat: true
        running: false
        onTriggered: shipUp()
    }

    MouseArea{
        id: dn
        x: 0
        y: parent.height/2
        width: parent.width/3
        height: parent.height/2
        enabled: direct
        onPressed: timerDn.start()
        onClicked: timerDn.stop()
        onExited: timerDn.stop()
        onEntered: timerDn.start()
    }

    Timer{
        id: timerDn
        interval: 50
        repeat: true
        running: false
        onTriggered: shipDn()
    }

    function shipUp(){                      // смещение вниз
        if(boom.visible==false){
        if(ship.y>0)shY-=height/100
        timerDn.stop()
        }
    }

    function shipDn(){
        if(boom.visible==false){
        if(ship.y<fon.height-ship.height)shY+=height/100
        timerUp.stop()
        }
    }
}

