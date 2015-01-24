import QtQuick 2.0

Item{
    id: scr
    width: 800
    height: 600
    x:0
    y:0

    property int size: 50     // относительный размер ядер (1/50) экрана
    property bool go: false   // обсчитывать полет ядер

    property int poligon: 7                                          // номер полигона
    property double kf: cFun.getPoligonWidth(poligon)/(width/size)   // масштаб к полигону
    property bool superLife: false          // неубиваемость

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

    // 11
    property bool vis11: false
    property int x11: 1
    property int y11: 1

    Image {
        id: boll11
        source: "qrc:/images/boll"
        x: x11
        y: y11
        width: scr.width/size
        height: width
        visible: vis11
        smooth: true
        fillMode: Image.Stretch

    }

    // 12
    property bool vis12: false
    property int x12: 1
    property int y12: 1

    Image {
        id: boll12
        source: "qrc:/images/boll"
        x: x12
        y: y12
        width: scr.width/size
        height: width
        visible: vis12
        smooth: true
        fillMode: Image.Stretch
    }

    // 13
    property bool vis13: false
    property int x13: 1
    property int y13: 1

    Image {
        id: boll13
        source: "qrc:/images/boll"
        x: x13
        y: y13
        width: scr.width/size
        height: width
        visible: vis13
        smooth: true
        fillMode: Image.Stretch
    }

    // 14
    property bool vis14: false
    property int x14: 1
    property int y14: 1

    Image {
        id: boll14
        source: "qrc:/images/boll"
        x: x14
        y: y14
        width: scr.width/size
        height: width
        visible: vis14
        smooth: true
        fillMode: Image.Stretch
    }

    // 15
    property bool vis15: false
    property int x15: 1
    property int y15: 1

    Image {
        id: boll15
        source: "qrc:/images/boll"
        x: x15
        y: y15
        width: scr.width/size
        height: width
        visible: vis15
        smooth: true
        fillMode: Image.Stretch
    }

    // 16
    property bool vis16: false
    property int x16: 1
    property int y16: 1

    Image {
        id: boll16
        source: "qrc:/images/boll"
        x: x16
        y: y16
        width: scr.width/size
        height: width
        visible: vis16
        smooth: true
        fillMode: Image.Stretch
    }

    // 17
    property bool vis17: false
    property int x17: 1
    property int y17: 1

    Image {
        id: boll17
        source: "qrc:/images/boll"
        x: x17
        y: y17
        width: scr.width/size
        height: width
        visible: vis17
        smooth: true
        fillMode: Image.Stretch
    }

    // 18
    property bool vis18: false
    property int x18: 1
    property int y18: 1

    Image {
        id: boll18
        source: "qrc:/images/boll"
        x: x18
        y: y18
        width: scr.width/size
        height: width
        visible: vis18
        smooth: true
        fillMode: Image.Stretch
    }

    // 19
    property bool vis19: false
    property int x19: 1
    property int y19: 1

    Image {
        id: boll19
        source: "qrc:/images/boll"
        x: x19
        y: y19
        width: scr.width/size
        height: width
        visible: vis19
        smooth: true
        fillMode: Image.Stretch
    }

    // 20
    property bool vis20: false
    property int x20: 1
    property int y20: 1

    Image {
        id: boll20
        source: "qrc:/images/boll"
        x: x20
        y: y20
        width: scr.width/size
        height: width
        visible: vis20
        smooth: true
        fillMode: Image.Stretch
    }

    function tmBollFlyStart(){
        tmShootBolls.start()
    }

    Timer {   // обработка летящих ядер
        id: tmShootBolls
        interval: 10
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
            if(vis11){
                if(cFun.getXYBoll(11)){
                    x11=cFun.getXBoll(11);y11=cFun.getYBoll(11)
                }else vis11=false
            }
            if(vis12){
                if(cFun.getXYBoll(12)){
                    x12=cFun.getXBoll(12);y12=cFun.getYBoll(12)
                }else vis12=false
            }
            if(vis13){
                if(cFun.getXYBoll(13)){
                    x13=cFun.getXBoll(13);y13=cFun.getYBoll(13)
                }else vis13=false
            }
            if(vis14){
                if(cFun.getXYBoll(14)){
                    x14=cFun.getXBoll(14);y14=cFun.getYBoll(14)
                }else vis14=false
            }
            if(vis15){
                if(cFun.getXYBoll(15)){
                    x15=cFun.getXBoll(15);y15=cFun.getYBoll(15)
                }else vis15=false
            }
            if(vis16){
                if(cFun.getXYBoll(16)){
                    x16=cFun.getXBoll(16);y16=cFun.getYBoll(16)
                }else vis16=false
            }
            if(vis17){
                if(cFun.getXYBoll(17)){
                    x17=cFun.getXBoll(17);y17=cFun.getYBoll(17)
                }else vis17=false
            }
            if(vis18){
                if(cFun.getXYBoll(18)){
                    x18=cFun.getXBoll(18);y18=cFun.getYBoll(18)
                }else vis18=false
            }
            if(vis19){
                if(cFun.getXYBoll(19)){
                    x19=cFun.getXBoll(19);y19=cFun.getYBoll(19)
                }else vis19=false
            }
            if(vis20){
                if(cFun.getXYBoll(20)){
                    x20=cFun.getXBoll(20);y20=cFun.getYBoll(20)
                }else vis20=false
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
        case 11:
            vis11=true
            x11=cFun.getXBoll(i)
            y11=cFun.getYBoll(i)
            break;
        case 12:
            vis12=true
            x12=cFun.getXBoll(i)
            y12=cFun.getYBoll(i)
            break;
        case 13:
            vis13=true
            x13=cFun.getXBoll(i)
            y13=cFun.getYBoll(i)
            break;
        case 14:
            vis14=true
            x14=cFun.getXBoll(i)
            y14=cFun.getYBoll(i)
            break;
        case 15:
            vis15=true
            x15=cFun.getXBoll(i)
            y15=cFun.getYBoll(i)
            break;
        case 16:
            vis16=true
            x16=cFun.getXBoll(i)
            y16=cFun.getYBoll(i)
            break;
        case 17:
            vis17=true
            x17=cFun.getXBoll(i)
            y17=cFun.getYBoll(i)
            break;
        case 18:
            vis18=true
            x18=cFun.getXBoll(i)
            y18=cFun.getYBoll(i)
            break;
        case 19:
            vis19=true
            x19=cFun.getXBoll(i)
            y19=cFun.getYBoll(i)
            break;
        case 20:
            vis20=true
            x20=cFun.getXBoll(i)
            y20=cFun.getYBoll(i)
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
        vis11=false;cFun.clearBoll(11)
        vis12=false;cFun.clearBoll(12)
        vis13=false;cFun.clearBoll(13)
        vis14=false;cFun.clearBoll(14)
        vis15=false;cFun.clearBoll(15)
        vis16=false;cFun.clearBoll(16)
        vis17=false;cFun.clearBoll(17)
        vis18=false;cFun.clearBoll(18)
        vis19=false;cFun.clearBoll(19)
        vis20=false;cFun.clearBoll(20)
    }

    function toShip(){ // проверка на попадание ядра в корабль
        if(superLife)return
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
            if(cFun.imposition(poligon,x4,y4,kf,shipp.poligon,shipp.shX,shipp.shY,shipp.kf)) {
                cFun.clearBoll(4)
                vis4=false
                showBoom()
            }
        }
        if(vis5 && x5-shipp.shX<shipp.shWidth){
            if(cFun.imposition(poligon,x5,y5,kf,shipp.poligon,shipp.shX,shipp.shY,shipp.kf)) {
                cFun.clearBoll(5)
                vis5=false
                showBoom()
            }
        }
        if(vis6 && x6-shipp.shX<shipp.shWidth){
            if(cFun.imposition(poligon,x6,y6,kf,shipp.poligon,shipp.shX,shipp.shY,shipp.kf)) {
                cFun.clearBoll(6)
                vis6=false
                showBoom()
            }
        }
        if(vis7 && x7-shipp.shX<shipp.shWidth){
            if(cFun.imposition(poligon,x7,y7,kf,shipp.poligon,shipp.shX,shipp.shY,shipp.kf)) {
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
        if(vis11 && x11-shipp.shX<shipp.shWidth){
            if(cFun.imposition(poligon,x11,y11,kf,shipp.poligon,shipp.shX,shipp.shY,shipp.kf)) {
                cFun.clearBoll(11)
                vis11=false
                showBoom()
            }
        }
        if(vis12 && x12-shipp.shX<shipp.shWidth){
            if(cFun.imposition(poligon,x12,y12,kf,shipp.poligon,shipp.shX,shipp.shY,shipp.kf)) {
                cFun.clearBoll(12)
                vis12=false
                showBoom()
            }
        }
        if(vis13 && x13-shipp.shX<shipp.shWidth){
            if(cFun.imposition(poligon,x13,y13,kf,shipp.poligon,shipp.shX,shipp.shY,shipp.kf)) {
                cFun.clearBoll(13)
                vis13=false
                showBoom()
            }
        }
        if(vis14 && x14-shipp.shX<shipp.shWidth){
            if(cFun.imposition(poligon,x14,y14,kf,shipp.poligon,shipp.shX,shipp.shY,shipp.kf)) {
                cFun.clearBoll(14)
                vis14=false
                showBoom()
            }
        }
        if(vis15 && x15-shipp.shX<shipp.shWidth){
            if(cFun.imposition(poligon,x15,y15,kf,shipp.poligon,shipp.shX,shipp.shY,shipp.kf)) {
                cFun.clearBoll(15)
                vis15=false
                showBoom()
            }
        }
        if(vis16 && x16-shipp.shX<shipp.shWidth){
            if(cFun.imposition(poligon,x16,y16,kf,shipp.poligon,shipp.shX,shipp.shY,shipp.kf)) {
                cFun.clearBoll(16)
                vis16=false
                showBoom()
            }
        }
        if(vis17 && x17-shipp.shX<shipp.shWidth){
            if(cFun.imposition(poligon,x17,y17,kf,shipp.poligon,shipp.shX,shipp.shY,shipp.kf)) {
                cFun.clearBoll(17)
                vis17=false
                showBoom()
            }
        }
        if(vis18 && x18-shipp.shX<shipp.shWidth){
            if(cFun.imposition(poligon,x18,y18,kf,shipp.poligon,shipp.shX,shipp.shY,shipp.kf)) {
                cFun.clearBoll(18)
                vis18=false
                showBoom()
            }
        }
        if(vis19 && x19-shipp.shX<shipp.shWidth){
            if(cFun.imposition(poligon,x19,y19,kf,shipp.poligon,shipp.shX,shipp.shY,shipp.kf)) {
                cFun.clearBoll(19)
                vis19=false
                showBoom()
            }
        }
        if(vis20 && x20-shipp.shX<shipp.shWidth){
            if(cFun.imposition(poligon,x20,y20,kf,shipp.poligon,shipp.shX,shipp.shY,shipp.kf)) {
                cFun.clearBoll(20)
                vis20=false
                showBoom()
            }
        }
    }
}

