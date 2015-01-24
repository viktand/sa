import QtQuick 2.0

Image {
     id: sp
     width: 100; height: 100
     x: leftSp
     smooth: true
     fillMode: Image.Stretch
     property int dur: 1
     property int indexSp: -1
     property int leftSp: 0
     property bool use: false
     property bool life: false
     property int type: 0
     property int endX: 0
     property int lastTime: 0
     property int poligon: 0
     property double kf: 1


     Connections{
         target: wind
         onClearSpr: sp.destroy()

     }

     ParallelAnimation {
            id: anim
            PropertyAnimation {
                target: sp
                properties: "x"
                to: endX
                duration: cFun.getSpeedKf()/dur   //30000/dur
            }
     }

     onLeftSpChanged: {
         anim.start()
     }

     Timer{
         id: tmr
         interval: 100
         running: true
         repeat: true
         onTriggered: {
             if(x==endX){
             sp.destroy()
             }
             else{
                 lastTime++
                 if(lastTime==20)lastTime=0;
                 if(sp.life) if(cFun.actPoint(type,lastTime) && shipp.shVis){
                        bls.showBollN(cFun.action2(type,x,y))
                 }
                 toShip()
                 toMissile()
             }
         }
     }

     function toShip(){ // проверка на столкновение с кораблем
        if(x<shipp.shX+shipp.shWidth){
            if((y>shipp.shY && y<shipp.shY+shipp.shHeight) || (y<shipp.shY && y+height>shipp.shY)){
                if(cFun.imposition(0,shipp.shX,shipp.shY,shipp.kf,poligon,x,y,kf)){
                    tmr.stop()
                    switch(cFun.getWithSheep(type)){
                    case 0: // пополнить ракеты
                        misPoc.count+=5
                        if(misPoc.count>misPoc.max)misPoc.count=misPoc.max
                        misPoc.missNo()
                        sp.destroy()
                        //cFun.clearSprites(s) - убрать бонус с экрана
                        break
                    case 1: // взрыв
                        showBoom()
                        break
                    }
                }
            }
        }
    }


     function toMissile(){  // попадание ракетой (проверка)
         if(missSh.missVisible){
             if(x-missSh.missX<missSh.missWidth*5 && x-missSh.missX>0){
                 if(missSh.missY>y && missSh.missY<y+height){
                     missSh.missVisible=false
                     missSh.shutTm(false)
                     missSh.setBoom2(x)
                     missSh.missX=-1
                     life=false
                     tmr2.start()

                 }
             }
         }
     }

     Timer{
         id: tmr2
         running: false
         repeat: false
         interval: 400
         onTriggered: {
             var i=cFun.getSecondPiligon(type)
             if(i===0){
                 sp.destroy()
                 return
             }
             source=cFun.getImage(i)
         }
     }
}
