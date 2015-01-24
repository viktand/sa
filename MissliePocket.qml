import QtQuick 2.0

Item{
    id: boss
    x: 0
    y: 0
    width: cFun.screenWidth()
    height: cFun.screenHeight()
    property int type: 0        // тип текущего оружия
    // 0 - простые ракеты
    property int max: 5         // максимальная текущая емкость
    property int count: 5       // остаток ракет (или чего-то еще)
    property string picture: "qrc:/images/miss"  // текущая картинка

    Image {
        id: miss1
        width: boss.width/32
        height: width*1.52
        x: tim.x-width
        y: 0
        source: picture
        smooth: true
        visible: true
        opacity: 0.3
        fillMode: Image.Stretch
    }

    Image {
        id: miss2
        width: boss.width/32
        height: width*1.52
        x: tim.x-width*2
        y: 0
        source: picture
        smooth: true
        visible: true
        opacity: 0.3
        fillMode: Image.Stretch
    }

    Image {
        id: miss3
        width: boss.width/32
        height: width*1.52
        x: tim.x-width*3
        y: 0
        source: picture
        smooth: true
        visible: true
        opacity: 0.3
        fillMode: Image.Stretch
    }

    Image {
        id: miss4
        width: boss.width/32
        height: width*1.52
        x: tim.x-width*4
        y: 0
        source: picture
        smooth: true
        visible: true
        opacity: 0.3
        fillMode: Image.Stretch
    }

    Image {
        id: miss5
        width: boss.width/32
        height: width*1.52
        x: tim.x-width*5
        y: 0
        source: picture
        smooth: true
        visible: true
        opacity: 0.3
        fillMode: Image.Stretch
    }

    function missNo(){          // отобразить кол-во ракет в соответствии с остатком
        switch (count){
        case 5:
            miss1.opacity=1
            miss2.opacity=1
            miss3.opacity=1
            miss4.opacity=1
            miss5.opacity=1
            break
        case 4:
            miss1.opacity=1
            miss2.opacity=1
            miss3.opacity=1
            miss4.opacity=1
            miss5.opacity=0.3
            break
        case 3:
            miss1.opacity=1
            miss2.opacity=1
            miss3.opacity=1
            miss4.opacity=0.3
            miss5.opacity=0.3
            break
        case 2:
            miss1.opacity=1
            miss2.opacity=1
            miss3.opacity=0.3
            miss4.opacity=0.3
            miss5.opacity=0.3
            break
        case 1:
            miss1.opacity=1
            miss2.opacity=0.3
            miss3.opacity=0.3
            miss4.opacity=0.3
            miss5.opacity=0.3
            break
        case 0:
            miss1.opacity=0.3
            miss2.opacity=0.3
            miss3.opacity=0.3
            miss4.opacity=0.3
            miss5.opacity=0.3
            break
        }
    }

}

