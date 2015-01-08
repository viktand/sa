import QtQuick 2.4
import QtQuick.Controls 1.3
import QtMultimedia 5.0


import screenSize 1.0


ApplicationWindow {
    id: window
    title: qsTr("Space adventure")
    width:  sf.screenWidth()
    height: sf.screenHeight()
    visible: true
    property int curentLivel: 0
    property bool bollsInFly: false
    property bool gameOn: false
    property int planetSpeed: 1000  // скорость стационарных объектов
    property int timeGm: 0          // время игры (глубина прохождения)
    property bool boomFlag: true    // можно показать взрыв корабля
    property int missShutCount: 5
    property int stoneBoom: -1      // № объекта, в который попала ракета

    ScreenFunctions{ // объект - ссылка на функции из screenSize.cpp
        id: sf
    }

    SoundEffect{
        id: auBoom
        source: "qrc:/music/chip.wav"

    }

    Rectangle{  // самая задняя картинка экрана
        id: fon
        width: parent.width
        height: parent.height
        x: 0
        y: 0
        Image {
            width: parent.width
            height: parent.height
            smooth: true
            anchors.centerIn: parent
            source: "qrc:/images/fon"
            fillMode: Image.Stretch
        }

    }

    Image{  // звезды, тихо ползущие 1
        id: strs1
        width: parent.width*1.2
        height: parent.height
        visible: true
        x: 0
        y: 0
        smooth: true
        source: "qrc:/images/stars"
        fillMode: Image.Stretch
    }

    Image{  // звезды, тихо ползущие 2
        id: strs2
        width: parent.width*1.2
        height: parent.height
        visible: true
        x: strs1.width
        y: 0
        smooth: true
        source: "qrc:/images/stars"
        fillMode: Image.Stretch
    }

    Image{  // поверхность планеты, тихо ползущяя 1
        id: planet1
        width: parent.width*1.2
        height: parent.height*0.1
        visible: false
        x: parent.width
        y: parent.height-height
        smooth: true
        source: "qrc:/images/planet"
        fillMode: Image.Stretch
    }

    Image{  // поверхность планеты, тихо ползущяя 2
        id: planet2
        width: parent.width*1.2
        height: parent.height*0.1
        visible: false
        x: planet1.x+planet1.width*0.9
        y: parent.height-height
        smooth: true
        source: "qrc:/images/planet"
        fillMode: Image.Stretch
    }

    Timer{  // двигатель изображения
        id: stars
        interval: 10
        repeat: true
        running: true
        property bool game: false
        onTriggered: {
            moveStarsAndPlanet()
            if(game){
                stones()
                if(boom.visible==false)booms()
            }
        }
    }

    function moveStarsAndPlanet(){
        if(strs1.x>(-1*strs1.width))strs1.x-=fon.width/5000
        else strs1.x=strs2.x+strs2.width
        if(strs2.x>(-1*strs2.width))strs2.x-=fon.width/5000
        else strs2.x=strs1.x+strs1.width
        if(planet1.visible){
            if(planet1.x>(-1*planet1.width))planet1.x-=fon.width/planetSpeed
            else planet1.x=planet2.x+planet2.width*0.9
            if(planet2.x>(-1*planet2.width))planet2.x-=fon.width/planetSpeed
            else planet2.x=planet1.x+planet1.width*0.9
        }
    }

    Ship {
        id: shipp
    }


    function endBoom(){ // вернуть объект в игру
        switch(stoneBoom){
        case 1:
            stone1.secondLife()
            break
        case 2:
            stone2.secondLife()
            break
        case 3:
            stone3.secondLife()
            break
        case 4:
            stone4.secondLife()
            break
        case 5:
            stone5.secondLife()
            break
        case 6:
            stone6.secondLife()
            break
        case 7:
            stone7.secondLife()
            break
        case 8:
            stone8.secondLife()
            break
        case 9:
            dot1.secondLife()
            break
        case 10:
            dot2.secondLife()
            break
        case 11:
            dot3.secondLife()
            break
        }

    }


    function missBoom(){        // проверка на попадание ракетой куда-нибудь
        if(timeGm<208){
            if(stone1.visible) stone1.missBoom()
            if(stone2.visible) stone2.missBoom()
            if(stone3.visible) stone3.missBoom()
            if(stone4.visible) stone4.missBoom()
            if(stone5.visible) stone5.missBoom()
            if(stone6.visible) stone6.missBoom()
            if(stone7.visible) stone7.missBoom()
            if(stone8.visible) stone8.missBoom()
        }
        if(timeGm>200){
            if(dot1.visible) dot1.missBoom()
            if(dot2.visible) dot2.missBoom()
            if(dot3.visible) dot3.missBoom()
            if(rock1.visible) rock1.missBoom()
        }
    }

    function missNo(){          // отобразить кол-во ракет в соответствии с остатком
        switch (missShutCount){
        case 5:
            miss1.visible=true
            miss2.visible=true
            miss3.visible=true
            miss4.visible=true
            miss5.visible=true
            break
        case 4:
            miss1.visible=true
            miss2.visible=true
            miss3.visible=true
            miss4.visible=true
            miss5.visible=false
            break
        case 3:
            miss1.visible=true
            miss2.visible=true
            miss3.visible=true
            miss4.visible=false
            miss5.visible=false
            break
        case 2:
            miss1.visible=true
            miss2.visible=true
            miss3.visible=false
            miss4.visible=false
            miss5.visible=false
            break
        case 1:
            miss1.visible=true
            miss2.visible=false
            miss3.visible=false
            miss4.visible=false
            miss5.visible=false
            break
        case 0:
            miss1.visible=false
            miss2.visible=false
            miss3.visible=false
            miss4.visible=false
            miss5.visible=false
            break
        }
    }





    SelectLivel{
        id: sell
        width: parent.width*0.8
        height: width/1.6
        x: (parent.width-width)/2
        y: (parent.height-height)/2
    }

    function startGame(){                 // запуск (перезапуск) всей игры
        btnStart.visible = false
        btnExit.visible = false
        sell.visible=true
        title.visible=false
        n1.visible=false
        n2.visible=false
        clearScreen()
    }

    function clearScreen(){ // убрать с экрана все объекты кроме неба
        stone1.visible = false
        stone2.visible = false
        stone3.visible = false
        stone4.visible = false
        stone5.visible = false
        stone6.visible = false
        stone7.visible = false
        stone8.visible = false
        planet1.visible=false
        planet2.visible=false
        dot1.visible=false
        dot2.visible=false
        dot3.visible=false
        rock1.visible=false
    }

    function startLiv(i){               // старт уровня i
        sell.visible=false
        shipp.shVis = true
        shipp.shX=fon.width/10
        shipp.shY=fon.height/2
        shipp.direct=true
        stars.game=true
        boomFlag=true
        switch(i){
        case 1:
            stone1.visible = true
            stone2.visible = true
            stone3.visible = true
            stone4.visible = true
            stone1.x=fon.width
            stone2.x=fon.width*1.1
            stone3.x=fon.width*1.5
            stone4.x=fon.width*1.3
            stone5.x=fon.width
            stone6.x=fon.width
            stone7.x=fon.width
            stone8.x=fon.width*2
            tmBig.start()
            timeGm=0
            tim.text="0"
            missShutCount=5
            missNo()
            n1.visible=true
            n1Timer.step=100
            n1Timer.start()
            curentLivel=1
            stonesUse()
            break

        case 2:
            setLivel2()
            timeGm=200
            tim.text="200"
            tmBig.start()
            missShutCount=5
            missNo()
            break
        }


        gameOn=true
    }

    MoveImages{
        id: stone1
        fonWidth: fon.width
        fonHeight: fon.height
        poligon: 1
        speed: 500
        screenWidth: 10
        go: true
        x: parent.width
        y: parent.height/2
        num: 1
    }

    MoveImages{
        id: stone2
        fonWidth: fon.width
        fonHeight: fon.height
        poligon: 1
        speed: 600
        screenWidth: 10
        x: parent.width*1.2
        y: parent.height/3
        go: true
        num: 2
    }

    MoveImages{
        id: stone3
        fonWidth: fon.width
        fonHeight: fon.height
        x: parent.width*1.5
        y: parent.height/1.5
        poligon: 1
        speed: 600
        go: true
        screenWidth: 10
        num: 3
    }

    MoveImages{
        id: stone4
        fonWidth: fon.width
        fonHeight: fon.height
        x: parent.width*2
        y: parent.width
        screenWidth: 10
        poligon: 2
        speed: 550
        go: true
        num: 4
    }

    MoveImages{
        id: stone5
        fonWidth: fon.width
        fonHeight: fon.height
        screenWidth: 6
        x: parent.width
        y: parent.height/5
        poligon: 4
        speed: 750
        go: true
        num: 5
    }

    MoveImages{
        id: stone6
        fonWidth: fon.width
        fonHeight: fon.height
        screenWidth: 10
        x: parent.width
        y: parent.height-height
        poligon: 3
        speed: 650
        go: true
        num: 6
    }

    MoveImages{
        id: stone7
        fonWidth: fon.width
        fonHeight: fon.height
        screenWidth: 5
        x: 0
        y: parent.height-height
        poligon: 3
        speed: 850
        go: true
        num: 7
    }

    MoveImages{
        id: stone8
        fonWidth: fon.width
        fonHeight: fon.height
        screenWidth: 4.5
        x: 0
        y: parent.height/2-height
        poligon: 5
        speed: 1000
        go: true
        num: 8
    }

    function stones(){ // движение камней и других объектов (не фон)
        stone1.move()
        stone2.move()
        stone3.move()
        stone4.move()
        stone5.move()
        stone6.move()
        stone7.move()
        stone8.move()
        if(curentLivel==2){
            dot1.move()
            dot2.move()
            rock1.move()
            if(rock1.x>fon.width)dot3.x=rock1.x+fon.width*0.1
            else dot3.move()
            bonusMissile.move()
            if(dot1.x<fon.width && dot1.x>fon.width*0.3 && gameOn)tmDot1.start()
                else tmDot1.stop()
            if(dot2.x<fon.width && dot2.x>fon.width*0.3 && gameOn)tmDot2.start()
                else tmDot2.stop()
            if(dot3.x<fon.width && dot3.x>fon.width*0.3 && gameOn)tmDot3.start()
                else tmDot3.stop()
            if(shipp.shY+shipp.shHeight>planet1.y+planet1.height*0.2 && timeGm>208)showBoom() // удар о поверхность
        }
    }

    function getPlace(px,wx){ // запрос возможности установить объект на указанном месте (2 уровень)
        switch(curentLivel){
        case 1:
            return 0
        case 2:
            if(px-dot1.x<dot1.width && px-dot1.x>0) return 0.2
            if(px-dot2.x<dot2.width && px-dot2.x>0) return 0.2
            if(px-rock1.x<rock1.width && px-rock1.x>0) return 0.4
            if(px+wx-dot1.x<dot1.width && px+wx-dot1.x>0) return 0.4
            if(px+wx-dot2.x<dot2.width && px+wx-dot2.x>0) return 0.4
            if(px+wx-rock1.x<rock1.width && px+wx-rock1.x>0) return 0.8
            return 0
        default:
            return 0
        }
    }

    function booms(){  // проверка на столкновение с камнем и прочими объектами
            if(timeGm<208){
                if(stone1.x-shipp.shX<shipp.shWidth && stone1.visible){
                    if(sf.imposition(0,shipp.shX,shipp.shY,shipp.kf,stone1.poligon,stone1.x,stone1.y,stone1.kf))showBoom()
                }
                if(stone2.x-shipp.shX<shipp.shWidth && stone2.visible){
                    if(sf.imposition(0,shipp.shX,shipp.shY,shipp.kf,stone2.poligon,stone2.x,stone2.y,stone2.kf))showBoom()
                }
                if(stone3.x-shipp.shX<shipp.shWidth && stone3.visible){
                    if(sf.imposition(0,shipp.shX,shipp.shY,shipp.kf,stone3.poligon,stone3.x,stone3.y,stone3.kf))showBoom()
                }
                if(stone4.x-shipp.shX<shipp.shWidth && stone4.visible){
                    if(sf.imposition(0,shipp.shX,shipp.shY,shipp.kf,stone4.poligon,stone4.x,stone4.y,stone4.kf))showBoom()
                }
                if(stone5.x-shipp.shX<shipp.shWidth && stone5.visible){
                    if(sf.imposition(0,shipp.shX,shipp.shY,shipp.kf,stone5.poligon,stone5.x,stone5.y,stone5.kf))showBoom()
                }
                if(stone6.x-shipp.shX<shipp.shWidth && stone6.visible){
                    if(sf.imposition(0,shipp.shX,shipp.shY,shipp.kf,stone6.poligon,stone6.x,stone6.y,stone6.kf))showBoom()
                }
                if(stone7.x-shipp.shX<shipp.shWidth && stone7.visible){
                    if(sf.imposition(0,shipp.shX,shipp.shY,shipp.kf,stone7.poligon,stone7.x,stone7.y,stone7.kf))showBoom()
                }
                if(stone8.x-shipp.shX<shipp.shWidth && stone8.visible){
                    if(sf.imposition(0,shipp.shX,shipp.shY,shipp.kf,stone8.poligon,stone8.x,stone8.y,stone8.kf))showBoom()
                }
                if(dot1.x-shipp.shX<shipp.shWidth && dot1.visible){
                    if(sf.imposition(0,shipp.shX,shipp.shY,shipp.kf,dot1.poligon,dot1.x,dot1.y,dot1.kf))showBoom()
                }
            }
            if(timeGm>208 && timeGm<400){
                if(dot1.x-shipp.shX<shipp.shWidth && dot1.visible){
                    if(sf.imposition(0,shipp.shX,shipp.shY,shipp.kf,dot1.poligon,dot1.x,dot1.y,dot1.kf))showBoom()
                }
                if(dot2.x-shipp.shX<shipp.shWidth && dot2.visible){
                    if(sf.imposition(0,shipp.shX,shipp.shY,shipp.kf,dot2.poligon,dot2.x,dot2.y,dot2.kf))showBoom()
                }
                if(dot3.x-shipp.shX<shipp.shWidth && dot3.visible){
                    if(sf.imposition(0,shipp.shX,shipp.shY,shipp.kf,dot3.poligon,dot3.x,dot3.y,dot3.kf))showBoom()
                }
                if(rock1.x-shipp.shX<shipp.shWidth && rock1.visible){
                    if(sf.imposition(0,shipp.shX,shipp.shY,shipp.kf,rock1.poligon,rock1.x,rock1.y,rock1.kf))showBoom()
                }
                if(bonusMissile.x-shipp.shX<shipp.shWidth && bonusMissile.visible){
                    if(sf.imposition(0,shipp.shX,shipp.shY,shipp.kf,bonusMissile.poligon,bonusMissile.x,bonusMissile.y,bonusMissile.kf)){
                        bonusMissile.visible=false
                        missShutCount=5
                        missNo()
                    }

                }
            }
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

    Timer{              // разрастание взрыва
        id: boomer
        interval: 3
        repeat: true
        running: false
        onTriggered: boomershow()
    }

    function showBoom(){ // показать взрыв корабля
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
            bls.stopAll()   // выключить ядра
            gameOn=false
            btnExit.visible=true
            btnStart.visible=true
            title.visible=true
            missShutCount=0
            missNo()
        }
    }

    Image {
        id: miss1
        width: parent.width/32
        height: width*1.52
        x: tim.x-width
        y: 0
        source: "qrc:/images/miss"
        smooth: true
        visible: false
        fillMode: Image.Stretch
    }

    Image {
        id: miss2
        width: parent.width/32
        height: width*1.52
        x: tim.x-width*2
        y: 0
        source: "qrc:/images/miss"
        smooth: true
        visible: false
        fillMode: Image.Stretch
    }

    Image {
        id: miss3
        width: parent.width/32
        height: width*1.52
        x: tim.x-width*3
        y: 0
        source: "qrc:/images/miss"
        smooth: true
        visible: false
        fillMode: Image.Stretch
    }

    Image {
        id: miss4
        width: parent.width/32
        height: width*1.52
        x: tim.x-width*4
        y: 0
        source: "qrc:/images/miss"
        smooth: true
        visible: false
        fillMode: Image.Stretch
    }

    Image {
        id: miss5
        width: parent.width/32
        height: width*1.52
        x: tim.x-width*5
        y: 0
        source: "qrc:/images/miss"
        smooth: true
        visible: false
        fillMode: Image.Stretch
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
        interval: 1000
        repeat: true
        running: false
        onTriggered: {
            if(shipp.shVis==true){
                timeGm++
                tim.text=timeGm.toString()
                if(timeGm==15)stone5.visible=true
                if(timeGm==30)stone6.visible=true
                if(timeGm==45)stone7.visible=true
                if(timeGm==55)stone8.visible=true
                if(timeGm==200) setLivel2()                // второй уровень
            }
        }
    }

    function setLivel2(){
        stonesNotUse()
        planet1.x=fon.width
        planet2.x=planet1.x+planet1.width*0.9
        dot1.x=fon.width*1.1
        dot2.x=fon.width*1.5
        dot3.x=fon.width*1.9
        rock1.x=fon.width*1.8
        dot1.visible=true
        dot2.visible=true
        dot3.visible=true
        rock1.visible=true
        curentLivel=2
        bls.tmBollFlyStart()
        n2.opacity=1
        n2.visible=true
        n1Timer.step=100
        n1Timer.start()
        planet1.visible=true
        planet2.visible=true
    }

    function stonesNotUse(){  //убрать камни из игры
        stone1.inUse=false
        stone2.inUse=false
        stone3.inUse=false
        stone4.inUse=false
        stone5.inUse=false
        stone6.inUse=false
        stone7.inUse=false
        stone8.inUse=false
    }

    function stonesUse(){   //вернуть камни в игру
        stone1.inUse=true
        stone2.inUse=true
        stone3.inUse=true
        stone4.inUse=true
        stone5.inUse=true
        stone6.inUse=true
        stone7.inUse=true
        stone8.inUse=true
    }


    MoveImages{ // башня с пушкой (маленькая такая)
        id: dot1
        poligon: 6
        poligon2: 9
        del: false
        x: fon.width*1.1
        y: fon.height - planet1.height-dot1.height/1.35
        fonWidth: fon.width
        fonHeight: fon.width
        screenWidth: 10
        screenHeight: 11
        speed: planetSpeed
        go: true
        visible: true
        xPos: fon.width*1.2
        rndPos: false
        num: 9
    }

    Timer{
        id: tmDot1
        interval: 500
        running: false
        repeat: true
        onTriggered: if(dot1.life)bls.showBollN(sf.shootBoll(dot1.x,dot1.y,fon.height/110))
    }


    MoveImages{ // башня с пушкой (маленькая такая)
        id: dot2
        poligon: 6
        poligon2: 9
        del: false
        x: fon.width*1.5
        y: fon.height - planet1.height-dot1.height/1.35
        fonWidth: fon.width
        fonHeight: fon.width
        screenWidth: 10
        screenHeight: 11
        speed: planetSpeed
        go: true
        visible: true
        xPos: fon.width*1.6
        rndPos: false
        num: 10
    }

    Timer{
        id: tmDot2
        interval: 500
        running: false
        repeat: true
        onTriggered: if(dot2.life)bls.showBollN(sf.shootBoll(dot2.x,dot2.y,fon.height/110))

    }

    MoveImages{ // Скала 1
        id: rock1
        poligon: 8
        poligon2: 8
        del: false
        x: fon.width*1.8
        y: fon.height - planet1.height-rock1.height/1.2
        fonWidth: fon.width
        fonHeight: fon.width
        screenWidth: 3
        screenHeight: 5
        speed: planetSpeed
        go: true
        visible: true
        xPos: fon.width*1.8
        rndPos: false
        num: 12
        planet: true
    }


    MoveImages{ // башня с пушкой (маленькая такая)
        id: dot3
        poligon: 6
        poligon2: 9
        del: false
        x: fon.width*2
        y: rock1.y-dot3.height/1.2
        fonWidth: fon.width
        fonHeight: fon.width
        screenWidth: 10
        screenHeight: 11
        speed: planetSpeed
        go: true
        visible: true
        xPos: fon.width*2
        rndPos: false
        num: 11
    }

    Timer{
        id: tmDot3
        interval: 300
        running: false
        repeat: true
        onTriggered: if(dot3.life)bls.showBollN(sf.shootBoll(dot3.x,dot3.y,fon.height/110))

    }

    MoveImages{  // бонусные ракеты - подбирать их надо, если конечно получится.
        id: bonusMissile
        poligon: 10
        speed: planetSpeed
        x: fon.width*1.3
        y: fon.height - planet1.height-height/1.6
        fonWidth: fon.width
        fonHeight: fon.width
        screenWidth: 20
        screenHeight: 25
        go: true
        visible: true
        rndPos: false
    }

    Image {
        id: n1
        source: "qrc:/images/n1"
        width: parent.width*0.3
        height: width
        x: (parent.width-width)/2
        y: (parent.height-height)/2
        visible: false
        smooth: true
        fillMode: Image.Stretch
    }

    Image {
        id: n2
        source: "qrc:/images/n2"
        width: parent.width*0.3
        height: width
        x: (parent.width-width)/2
        y: (parent.height-height)/2
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
        width: parent.width
        height: parent.height
    }

    Mbutton{        // кнопка "Старт" - запуск/перезапуск игры
        id: btnStart
        button_text: "Start"
        x: parent.width/2-width/2
        y: parent.height/2-height*1.125
        widthUsers: parent.width/5
        heightUsers: parent.height/5
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
        x: parent.width/2-width/2
        y: parent.height/2+height/8
        widthUsers: parent.width/5
        heightUsers: parent.height/5
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
        width: parent.width*0.63
        height: width/8
        x: (parent.width-width)/2
        y: width/10
        visible: true
        smooth: true
        fillMode: Image.Stretch
    }

    Missile{
        id: missSh
    }
}
