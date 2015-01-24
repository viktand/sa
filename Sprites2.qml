import QtQuick 2.0

 Item {
     id: spContainer
     x: 0; y: 0
     width: fon.width; height: fon.height
     property int num: 0

     function switchOn(i,x,y,w,h,p,l,v,pl,k){ // включить спрайт
         var component = Qt.createComponent("qrc:/SingleSprite.qml");
         console.log(p+"-"+i+"-"+x+"-"+y+"-"+w+"-"+h+":"+v+":"+pl+":"+k+":"+l)
         //info.text="add sprite type "+t+" in #"+i;
         var object = component.createObject(spContainer)
         object.x=x;object.y=y;object.width=w;object.height=h
         object.source=p
         object.use=true
         object.life=l
         object.type=i
         object.dur=v
         object.poligon=pl
         object.kf=k
         object.endX=-1*fon.width
         object.leftSp=fon.width
         object.indexSp=++num
     }
 }
