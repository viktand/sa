import QtQuick 2.0

// ракета

Item{
    id: scr
    width: cFun.screenWidth()
    height: cFun.screenHeight()
    x:0
    y:0
    property bool missVisible: false
    property int missX: 0
    property int missY: 0
    property int missWidth: width/64
    property int sprite: 0   // куда попало


    Image { // ракета - выстрел (которая типа летит)
        id: missShut
        width: missWidth
        height: width/1.52
        x: missX
        y: missY
        source: "qrc:/images/miss2"
        smooth: true
        visible: missVisible
        fillMode: Image.Stretch
        property int count: 5
    }

    Image { // картинка взрыва
        id: missileBoom
        height: width
        width: 0
        source: "qrc:/images/boom2"
        smooth: true
        visible: false
        fillMode: Image.Stretch
        property int stone: 0 // номер камня или другого объекта, который взрывается
    }

    Timer { // таймер разрастания картинки взрыва ракеты
        id: showBoom2
        interval: 10
        repeat: true
        onTriggered: showBoomShow()
    }

    function setBoom2(xBoom){ // задать точку взрыва камня
        missileBoom.width=1
        missileBoom.x=xBoom  // missShut.x+missShut.width
        missileBoom.y=missShut.y+missShut.height/2
        showBoom2.start()
        missileBoom.visible=true
        auBoom.play()
    }

    function showBoomShow(){ // прорисовка взрыва ракеты
        if(missileBoom.width<width/5){
            missileBoom.width+=width/100
            missileBoom.x-=width/200
            missileBoom.y-=width/200
        }
        else {
            missileBoom.visible=false
            showBoom2.stop()
        }
    }

    function start(){    // выстрел
        misPoc.count--        // уменьшить количество ракет в запасе
        missVisible=true   // показать ракету ракету
        missY=shipp.shY       // установить ракету
        missX=shipp.shX+shipp.shWidth*0.7
        shutTimer.start()       // включить таймер анимации ракеты
        misPoc.missNo()                // отобразить остаток ракет
    }

    function shutTm(b){
        if(b)shutTimer.start()
        else shutTimer.stop()
    }

    Timer {
        id: shutTimer
        interval: 5
        repeat: true
        running: false
        onTriggered: shutDo()
    }

    function shutDo(){          // Выстрел (движение ракеты)
        if(missX<width){
            missX+=width/100
        }
        else{
            shutTimer.stop()
            missVisible=false
        }
    }
}

