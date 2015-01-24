import QtQuick 2.0

// Катринка на со ссылкой на полигон и функциями обработки движения и столкновения


Image {
    id: stone

    property int poligon: 2                                      // номер полигона
    property double kf: cFun.getPoligonWidth(poligon)/width      // масштаб к полигону
    property int speed: 512                                      // скорость
    property bool go: true                                       // перемещаемость
    property bool inUse: true                                    // необходимость обработки
    property int fonWidth: 1024                                  // ширина экран
    property int fonHeight: 768                                  // высота экрана
    property double screenWidth: 10                              // отношение ширины к ширине экрана
    property double screenHeight: screenWidth                    // отношение высоты к ширине экрана
    property bool rndPos: true                                   // пересчитывать случайную координату по Y
    property int xPos: fonWidth                                  // позиция по Х при перезапуске движения
    property bool del: true                                      // удаляемость объекта (после взрыва)
    property int poligon2: 0                                     // второй полигон (для возможной замены вида объекта)
    property int poligon1: poligon
    property int num: -1                                         // номер объекта, который он :)
    property bool life: true                                     // объект "жив"
    property bool planet: false                                  // объект неподвижен на планете (скала)
    property bool fromMap: false                                 // подгружать новый х из карты
    width: fonWidth/screenWidth
    height: fonWidth/screenHeight
    x: 0
    y: 0
    source: cFun.getImage(poligon1)
    smooth: true
    visible: false
    fillMode: Image.Stretch

//    Text{
//        id: label
//        x:stone.width/2
//        y:stone.height/2
//        width: stone.width
//        height: stone.height/2
//        text: ""
//        color: "#00FF00"
//    }

    function move(){ // смещение влево
        if(x>(-1*width)){
            if(go){
                x-=fonWidth/speed
            }
        }
        else {
            if(inUse){
                visible=true
                if(fromMap){
                   // label.text=cFun.getIndex()+1
                    //x=fonWidth+fonWidth*cFun.getPoint()
                }
                else x=xPos
                if(rndPos)y=cFun.getRND(fonHeight-height)
                if(poligon1==poligon2)poligon1=poligon
                life=true
            }
        }
    }

    function missBoom(){  // попадание ракетой
        if(x-missSh.missX<missSh.missWidth && x-missSh.missX>0){
            if(missSh.missY>y && missSh.missY<y+height){
                go=planet
                stoneBoom=num
                missSh.missVisible=false
                missSh.shutTm(false)
                missSh.setBoom2()
            }
        }
    }

    function secondLife(){  // поведение после взрыва
        go=true
        life=false
        if(del){
            x=(-1*stone1.width)
        } else {
            poligon1=poligon2
        }
    }
}

