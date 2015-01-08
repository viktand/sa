import QtQuick 2.0

Rectangle {
  id: container

  property string button_text: "button"
  property int horizontalPadding: 25    // Горизонтальный отступ от границ текста
  property int verticalPadding: 10      // Вертикальный отступ от границ текста
  property int widthUsers: title_object.width + horizontalPadding  // ширина кнопки
  property int heightUsers: title_object.height + verticalPadding  // высота кнопки
  property int cornerRadius: 16          // Радиус скругления углов

  signal senderClicked  // Сигнал, вызываемый по клику мышкой

  // Фоновой градиент
  property Gradient backNormal: Gradient {
    GradientStop { position: 0.0; color: "#3030FF" }
    GradientStop { position: 0.2; color: "#55CFFF" }
    GradientStop { position: 1.0; color: "#3030FF" }
  }

  // Фоновой градиент, который отображается в нажатом состоянии
  property Gradient backPressed: Gradient {
     GradientStop { position: 0.0; color: "#3030FF" }
     GradientStop { position: 0.2; color: "#55CFFF" }
     GradientStop { position: 1.0; color: "#3030FF" }
  }

  width: widthUsers
  height: heightUsers
  radius: cornerRadius

  // Цвет границы (обводки) кнопки
  border.color: "#999999"

  // Толщина границы в пикселях. Обрати внимание -
  // тут тоже идёт привязка к СВОЙСТВУ MouseArea, которое
  // при попадании курсора мыши в область кнопки сразу же
  // станет true и повлечёт за собой увеличение border.width до 2
  // и сразу произойдёт обновление границы на экране,
  // а когда курсор мыши покидает область кнопки,
  // border.width снова станет единицей
  // Прикольно, не правда ли? Прикинь, анон, сколько строк кода
  // надо написать в С++, чтобы следать текую связку, а тут - одной строкой :)
  border.width: mouseLayout.containsMouse ? 2 : 1

  // Фоновой градиент, привязан к нажатию левой кнопки мыши.
  // Конда она в нажатом состоянии, показывается градиент
  // из свойства container.backpressed, если отпущена - conteiner.backNormal
  gradient: mouseLayout.pressed ? container.backPressed : container.backNormal

  // Текст заголовка кнопки
  Text {
    id: title_object

    // Позиционируем в центр области
    anchors.centerIn: parent

    // Цвет шрифта
    color: "#FFFF2F"

    // Текст, привязан к свойству container.button_text
    text: container.button_text
  }

  // Область, которая реагирует на события мыши
  MouseArea {
    id: mouseLayout
    anchors.fill: parent
    hoverEnabled: true
  }

  // Вызывается когда компонент создан
  Component.onCompleted:
  {
    // Один из ключевых моментов - мы связываем сигнал с сигналом
    mouseLayout.clicked.connect(senderClicked);
  }
}

