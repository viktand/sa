import QtQuick 2.0

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
    property double setDirect: 0.5
    property double setShut: 0.5

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
        x: parent.width-width
        y: shipBig.height-shipBig.height*setShut
        width: parent.width/3
        height: parent.height*setShut
        enabled: direct
        onClicked: {
            if(missSh.missVisible==false && misPoc.count>0){
               missSh.start()
            }
        }
        Image {
            id: shutPic
            x: shut.width-width
            y: 0
            width: height
            height: shut.height
            source: "qrc:/images/miss3"
            smooth: true
            fillMode: Image.Stretch
            opacity: 0.09
            visible: gameOn
        }
    }

    MouseArea{
        id: up
        x: 0
        y: shipBig.height-shipBig.height*setDirect
        width: shipBig.width/3
        height: (shipBig.height*setDirect)/2
        enabled: direct
        onPressed: timerUp.start()
        onClicked: timerUp.stop()
        onExited: timerUp.stop()
        onEntered: timerUp.start()
        Image {
            id: upPic
            x: 0
            y: 0
            width: up.height
            height: width
            source: "qrc:/images/up"
            smooth: true
            fillMode: Image.Stretch
            opacity: 0.09
            visible: gameOn
        }
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
        y: shipBig.height-(shipBig.height/2)*setDirect
        width: parent.width/3
        height: (shipBig.height*setDirect)/2
        enabled: direct
        onPressed: timerDn.start()
        onClicked: timerDn.stop()
        onExited: timerDn.stop()
        onEntered: timerDn.start()
        Image {
            id: downPic
            x: 0
            y: dn.height-height
            width: dn.height
            height: width
            source: "qrc:/images/down"
            smooth: true
            fillMode: Image.Stretch
            opacity: 0.09
            visible: gameOn
        }
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

