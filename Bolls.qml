import QtQuick 2.0
import screenSize 1.0

Item{
    id: scr
    width: 800
    height: 600
    x:0
    y:0

    ScreenFunctions{
        id: cFun
    }

    property int size: 50     // относительный размер ядер (1/50) экрана
    property bool go: false   // обсчитывать полет ядер

    property int poligon: 7                                          // номер полигона
    property double kf: cFun.getPoligonWidth(poligon)/(width/size)   // масштаб к полигону

    // 1
    property bool vis1: false
    property int x1: 1
    property int y1: 1

    Image {
        id: boll1
        source: "qrc:/images/boll"
        x: x1
        y: y1
        width: scr.width/size
        height: width
        visible: vis1
        smooth: true
        fillMode: Image.Stretch

    }

    // 2
    property bool vis2: false
    property int x2: 1
    property int y2: 1

    Image {
        id: boll2
        source: "qrc:/images/boll"
        x: x2
        y: y2
        width: scr.width/size
        height: width
        visible: vis2
        smooth: true
        fillMode: Image.Stretch
    }

    // 3
    property bool vis3: false
    property int x3: 1
    property int y3: 1

    Image {
        id: boll3
        source: "qrc:/images/boll"
        x: x3
        y: y3
        width: scr.width/size
        height: width
        visible: vis3
        smooth: true
        fillMode: Image.Stretch
    }

    // 4
    property bool vis4: false
    property int x4: 1
    property int y4: 1

    Image {
        id: boll4
        source: "qrc:/images/boll"
        x: x4
        y: y4
        width: scr.width/size
        height: width
        visible: vis4
        smooth: true
        fillMode: Image.Stretch
    }

    // 5
    property bool vis5: false
    property int x5: 1
    property int y5: 1

    Image {
        id: boll5
        source: "qrc:/images/boll"
        x: x5
        y: y5
        width: scr.width/size
        height: width
        visible: vis5
        smooth: true
        fillMode: Image.Stretch
    }

    // 6
    property bool vis6: false
    property int x6: 1
    property int y6: 1

    Image {
        id: boll6
        source: "qrc:/images/boll"
        x: x6
        y: y6
        width: scr.width/size
        height: width
        visible: vis6
        smooth: true
        fillMode: Image.Stretch
    }

    // 7
    property bool vis7: false
    property int x7: 1
    property int y7: 1

    Image {
        id: boll7
        source: "qrc:/images/boll"
        x: x7
        y: y7
        width: scr.width/size
        height: width
        visible: vis7
        smooth: true
        fillMode: Image.Stretch
    }

    // 8
    property bool vis8: false
    property int x8: 1
    property int y8: 1

    Image {
        id: boll8
        source: "qrc:/images/boll"
        x: x8
        y: y8
        width: scr.width/size
        height: width
        visible: vis8
        smooth: true
        fillMode: Image.Stretch
    }

    // 9
    property bool vis9: false
    property int x9: 1
    property int y9: 1

    Image {
        id: boll9
        source: "qrc:/images/boll"
        x: x9
        y: y9
        width: scr.width/size
        height: width
        visible: vis9
        smooth: true
        fillMode: Image.Stretch
    }

    // 10
    property bool vis10: false
    property int x10: 1
    property int y10: 1

    Image {
        id: boll10
        source: "qrc:/images/boll"
        x: x10
        y: y10
        width: scr.width/size
        height: width
        visible: vis10
        smooth: true
        fillMode: Image.Stretch
    }

    function tmBollFlyStart(){
        tmShootBolls.start()
    }

    Timer {   // обработка летящих ядер
        id: tmShootBolls
        interval: 20
        repeat: true
        running: true
        onTriggered: {
            if(vis1){
                if(cFun.getXYBoll(1)){
                    x1=cFun.getXBoll(1);y1=cFun.getYBoll(1)
                }else vis1=false
            }
            if(vis2){
                if(cFun.getXYBoll(2)){
                    x2=cFun.getXBoll(2);y2=cFun.getYBoll(2)
                }else vis2=false
            }
            if(vis3){
                if(cFun.getXYBoll(3)){
                    x3=cFun.getXBoll(3);y3=cFun.getYBoll(3)
                }else vis3=false
            }
            if(vis4){
                if(cFun.getXYBoll(4)){
                    x4=cFun.getXBoll(4);y4=cFun.getYBoll(4)
                }else vis4=false
            }
            if(vis5){
                if(cFun.getXYBoll(5)){
                    x5=cFun.getXBoll(5);y5=cFun.getYBoll(5)
                }else vis5=false
            }
            if(vis6){
                if(cFun.getXYBoll(6)){
                    x6=cFun.getXBoll(6);y6=cFun.getYBoll(6)
                }else vis6=false
            }
            if(vis7){
                if(cFun.getXYBoll(7)){
                    x7=cFun.getXBoll(7);y7=cFun.getYBoll(7)
                }else vis7=false
            }
            if(vis8){
                if(cFun.getXYBoll(8)){
                    x8=cFun.getXBoll(8);y8=cFun.getYBoll(8)
                }else vis8=false
            }
            if(vis9){
                if(cFun.getXYBoll(9)){
                    x9=cFun.getXBoll(9);y9=cFun.getYBoll(9)
                }else vis9=false
            }
            if(vis10){
                if(cFun.getXYBoll(10)){
                    x10=cFun.getXBoll(10);y10=cFun.getYBoll(10)
                }else vis10=false
            }
            toShip()
        }
    }

    function showBollN(i){
        switch(i){
        case 1:
            vis1=true
            x1=cFun.getXBoll(i)
            y1=cFun.getYBoll(i)
            break;
        case 2:
            vis2=true
            x2=cFun.getXBoll(i)
            y2=cFun.getYBoll(i)
            break;
        case 3:
            vis3=true
            x3=cFun.getXBoll(i)
            y3=cFun.getYBoll(i)
            break;
        case 4:
            vis4=true
            x4=cFun.getXBoll(i)
            y4=cFun.getYBoll(i)
            break;
        case 5:
            vis5=true
            x5=cFun.getXBoll(i)
            y5=cFun.getYBoll(i)
            break;
        case 6:
            vis6=true
            x6=cFun.getXBoll(i)
            y6=cFun.getYBoll(i)
            break;
        case 7:
            vis7=true
            x7=cFun.getXBoll(i)
            y7=cFun.getYBoll(i)
            break;
        case 8:
            vis8=true
            x8=cFun.getXBoll(i)
            y8=cFun.getYBoll(i)
            break;
        case 9:
            vis9=true
            x9=cFun.getXBoll(i)
            y9=cFun.getYBoll(i)
            break;
        case 10:
            vis10=true
            x10=cFun.getXBoll(i)
            y10=cFun.getYBoll(i)
            break;
        }
    }

    function stopAll(){
        tmShootBolls.stop()
        vis1=false;cFun.clearBoll(1)
        vis2=false;cFun.clearBoll(2)
        vis3=false;cFun.clearBoll(3)
        vis4=false;cFun.clearBoll(4)
        vis5=false;cFun.clearBoll(5)
        vis6=false;cFun.clearBoll(6)
        vis7=false;cFun.clearBoll(7)
        vis8=false;cFun.clearBoll(8)
        vis9=false;cFun.clearBoll(9)
        vis10=false;cFun.clearBoll(10)
    }

    function toShip(){ // проверка на попадание ядра в корабль
        if(vis1 && x1-shipp.shX<shipp.shWidth){
            if(cFun.imposition(poligon,x1,y1,kf,shipp.poligon,shipp.shX,shipp.shY,shipp.kf)) {
                cFun.clearBoll(1)
                vis1=false
                showBoom()
            }
        }
        if(vis2 && x2-shipp.shX<shipp.shWidth){
            if(cFun.imposition(poligon,x2,y2,kf,shipp.poligon,shipp.shX,shipp.shY,shipp.kf)) {
                cFun.clearBoll(2)
                vis2=false
                showBoom()
            }
        }
        if(vis3 && x3-shipp.shX<shipp.shWidth){
            if(cFun.imposition(poligon,x3,y3,kf,shipp.poligon,shipp.shX,shipp.shY,shipp.kf)) {
                cFun.clearBoll(3)
                vis3=false
                showBoom()
            }
        }
        if(vis4 && x4-shipp.shX<shipp.shWidth){
            if(cFun.imposition(poligon,x1,y4,kf,shipp.poligon,shipp.shX,shipp.shY,shipp.kf)) {
                cFun.clearBoll(4)
                vis4=false
                showBoom()
            }
        }
        if(vis5 && x5-shipp.shX<shipp.shWidth){
            if(cFun.imposition(poligon,x1,y5,kf,shipp.poligon,shipp.shX,shipp.shY,shipp.kf)) {
                cFun.clearBoll(5)
                vis5=false
                showBoom()
            }
        }
        if(vis6 && x6-shipp.shX<shipp.shWidth){
            if(cFun.imposition(poligon,x1,y6,kf,shipp.poligon,shipp.shX,shipp.shY,shipp.kf)) {
                cFun.clearBoll(6)
                vis6=false
                showBoom()
            }
        }
        if(vis7 && x7-shipp.shX<shipp.shWidth){
            if(cFun.imposition(poligon,x1,y7,kf,shipp.poligon,shipp.shX,shipp.shY,shipp.kf)) {
                cFun.clearBoll(7)
                vis7=false
                showBoom()
            }
        }
        if(vis8 && x8-shipp.shX<shipp.shWidth){
            if(cFun.imposition(poligon,x8,y8,kf,shipp.poligon,shipp.shX,shipp.shY,shipp.kf)) {
                cFun.clearBoll(8)
                vis8=false
                showBoom()
            }
        }
        if(vis9 && x9-shipp.shX<shipp.shWidth){
            if(cFun.imposition(poligon,x9,y9,kf,shipp.poligon,shipp.shX,shipp.shY,shipp.kf)) {
                cFun.clearBoll(9)
                vis9=false
                showBoom()
            }
        }
        if(vis10 && x10-shipp.shX<shipp.shWidth){
            if(cFun.imposition(poligon,x10,y10,kf,shipp.poligon,shipp.shX,shipp.shY,shipp.kf)) {
                cFun.clearBoll(10)
                vis10=false
                showBoom()
            }
        }

    }
}

