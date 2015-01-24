import QtQuick 2.4
import QtQuick.Controls 1.3
import QtMultimedia 5.0
import QtQuick.Window 2.1


import screenSize 1.0


Window {
    id: wind
    visible: true
    visibility: "FullScreen"
    x: 0
    y: 0
    title: qsTr("Space adventure")
    width:  cFun.screenWidth()
    height: cFun.screenHeight()
    property int curentLivel: 0
    property double kW: fon.width/1280
    property double kH: fon.height/1024
    property bool bollsInFly: false
    property bool gameOn: false
    property int planetSpeed: width/500  // скорость стационарных объектов
    property int timeGm: 0                  // время игры (глубина прохождения)
    property bool boomFlag: true            // можно показать взрыв корабля
    property int stoneBoom: -1              // № объекта, в который попала ракета
    property int tsheft: 0                  // смещение времени
    signal clearSpr                         // убрать все спрайты

    ScreenFunctions{ // объект - ссылка на функции из screenSize.cpp
        id: cFun
        onDrawSprite: sp2.switchOn(i,x,y,w,h,p,l,v,pl,k)
        onInfo: setTextInfo(st)
    }

    function setTextInfo(st){
        info.text=st
    }

    SoundEffect{
        id: auBoom
        source: "qrc:/music/chip.wav"

    }

    Rectangle{  // самая задняя картинка экрана
        id: fon
        width: cFun.screenWidth()
        height: cFun.screenHeight()
        x: 0
        y: 0
        Image {
            width: fon.width
            height: fon.height
            smooth: true
            anchors.centerIn: parent
            source: "qrc:/images/fon"
            fillMode: Image.Stretch
        }
    }

    Image{  // звезды, тихо ползущие 1
        id: strs1
        width: fon.width*1.2
        height: fon.height
        visible: true
        x: 0
        y: 0
        smooth: true
        source: "qrc:/images/stars"
        fillMode: Image.Stretch
    }


    Image{  // звезды, тихо ползущие 2
        id: strs2
        width: fon.width*1.2
        height: fon.height
        visible: true
        x: strs1.width
        y: 0
        smooth: true
        source: "qrc:/images/stars"
        fillMode: Image.Stretch
    }


    Sprites2{
        id: sp2
    }

    Timer{
        id: actTm
        interval: 50
        repeat: true
        running: true
        onTriggered: cFun.incTime()
    }

    Timer{  // двигатель изображения
        id: stars
        interval: 20
        repeat: true
        running: true
        property bool game: false
        onTriggered: { 
            moveStarsAndPlanet()
        }
    }

    function moveStarsAndPlanet(){
        if(strs1.x>(-1*strs1.width))strs1.x-=fon.width/5000
        else strs1.x=strs2.x+strs2.width
        if(strs2.x>(-1*strs2.width))strs2.x-=fon.width/5000
        else strs2.x=strs1.x+strs1.width
    }

    Ship {
        id: shipp
    }


    SelectLivel{
        id: sell
        width: fon.width*0.8
        height: width/1.6
        x: (fon.width-width)/2
        y: (fon.height-height)/2
    }

    function startGame(){                 // запуск (перезапуск) всей игры
        btnStart.visible = false
        btnExit.visible = false
        sell.visible=true
        title.visible=false
        n1.visible=false
        n2.visible=false

    }

    function startLiv(i){               // старт уровня i
        sell.visible=false
        shipp.shVis = true
        shipp.shX=fon.width/10
        shipp.shY=fon.height/2
        shipp.direct=true
        stars.game=true
        boomFlag=true
        gameOn=true
        clearSpr()
        switch(i){
        case 1:
            setLivel1()
            timeGm=0
            tim.text="0"
            tmBig.start()
            misPoc.count=misPoc.max
            misPoc.missNo()
            break

        case 2:
            setLivel2()
            timeGm=199
            tim.text="199"
            tmBig.start()
            misPoc.count=misPoc.max
            misPoc.missNo()
            break
        }
        gameOn=true
    }



    Timer{              // разрастание взрыва
        id: boomer
        interval: 3
        repeat: true
        running: false
        onTriggered: boomershow()
    }

    function showBoom(xboom){ // показать взрыв корабля
        if(shipp.shVis && boomFlag) {
            boomFlag=false
            boom.width=1
            boom.height=1
            boom.x=shipp.shX+shipp.shWidth/2
            boom.y=shipp.shY+shipp.shHeight/2
            boomer.start()
            boom.visible=true
        }
    }

    function boomershow(){ // рисование взрыва корабля
        boom.x=boom.x-fon.width/200
        boom.y=boom.y-fon.width/200
        boom.width=boom.width+fon.width/100
        boom.height=boom.height+fon.width/100
        if(boom.width > fon.width/3){
            shipp.shVis=false
            boom.visible=false
            boomer.stop()
            gameOn=false;
            bls.stopAll()   // выключить ядра
            gameOn=false
            btnExit.visible=true
            btnStart.visible=true
            title.visible=true
            misPoc.count=0
            misPoc.missNo()
        }
    }

    Text {
         id: tim
         color: "#00FF00"
         text: "0"
         width: fon.width/20
         height: fon.height/20
         y: 0
         x: fon.width-width
     }

    Timer {                        // **************************   основной таймер прохождения уровней
        id: tmBig
        interval: 128
        repeat: true
        running: false
        onTriggered: {
            tsheft++
            if(shipp.shVis){
                if(tsheft>9){
                    tsheft=0
                    timeGm++
                }
                cFun.setObj(timeGm,tsheft)
                tim.text=timeGm.toString()
                if(timeGm==199) setLivel2()                // второй уровень
            }
        }
    }

    function setLivel1(){
        cFun.loadLivel(1)
        curentLivel=1
        bls.tmBollFlyStart()
        n1.opacity=1
        n1.visible=true
        n1Timer.step=100
        n1Timer.start()
    }

    function setLivel2(){
        cFun.loadLivel(2)
        curentLivel=2
        bls.tmBollFlyStart()
        n2.opacity=1
        n2.visible=true
        n1Timer.step=100
        n1Timer.start()
    }

    Image {
        id: n1
        source: "qrc:/images/n1"
        width: fon.width*0.3
        height: width
        x: (fon.width-width)/2
        y: (fon.height-height)/2
        visible: false
        smooth: true
        fillMode: Image.Stretch
    }

    Image {
        id: n2
        source: "qrc:/images/n2"
        width: fon.width*0.3
        height: width
        x: (fon.width-width)/2
        y: (fon.height-height)/2
        visible: false
        smooth: true
        fillMode: Image.Stretch
    }

    Timer {  // транспорант начала уровня (плавно исчезающий)
        id: n1Timer
        interval: 50
        repeat: true
        running: false
        property int step: 0
        onTriggered: {
            step--
            if(step<51){
                n1.opacity-=0.02
                n2.opacity-=0.02
                if(step==0){
                    n1Timer.stop()
                    n1.visible=false
                    n2.visible=false
                }
            }

        }
    }

    // Ядра

    Bolls {
        id: bls
        x: 0
        y: 0
        width: fon.width
        height: fon.height
    }

    Mbutton{        // кнопка "Старт" - запуск/перезапуск игры
        id: btnStart
        button_text: "Start"
        x: fon.width/2-width/2
        y: fon.height/2-height*1.125
        widthUsers: fon.width/5
        heightUsers: fon.height/5
        MouseArea {
          id: mouseLayout1
          anchors.fill: parent
          hoverEnabled: true
          onClicked: startGame()
        }
    }

    Mbutton{        // кнопка "выход" - закрыть программу
        id: btnExit
        button_text: "Exit"
        x: fon.width/2-width/2
        y: fon.height/2+height/8
        widthUsers: fon.width/5
        heightUsers: fon.height/5
        MouseArea {
          id: mouseLayout2
          anchors.fill: parent
          hoverEnabled: true
          onClicked: Qt.quit()
        }
    }

    Image {
        id: title
        source: "qrc:/images/title"
        width: fon.width*0.63
        height: width/8
        x: (fon.width-width)/2
        y: width/10
        visible: true
        smooth: true
        fillMode: Image.Stretch
    }

    Image {             // взрыв корабля (картинка)
        id: boom
        width: 1
        height: 1
        x: shipp.shX+shipp.shWidth/2
        y: shipp.shY+shipp.shHeight/2
        source: "qrc:/images/boom"
        smooth: true
        visible: false
        fillMode: Image.Stretch
    }

    Missile{
        id: missSh
    }

    Text{
        id: info
        x: 0
        y: 0
        width: fon.width
        height: fon.height
        text: ""
        color: "#00FF00"
    }

    MissliePocket{
        id: misPoc
    }


}
