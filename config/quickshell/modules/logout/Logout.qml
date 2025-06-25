pragma ComponentBehavior: Bound
import QtQuick
import QtQuick.Layouts
import QtQuick.Effects
import Quickshell
import Quickshell.Widgets
import Quickshell.Wayland
import "../../widgets"
import "../../config"

Variants {
  id: root
  property color backgroundColor: "#1e1e2e99"
	property color buttonColor: "#1e1e1e00"
	property color buttonHoverColor: "#cba6f7"
  default property list<LogoutButton> buttons

  model: Quickshell.screens
  PanelWindow {
    id: w

    property var modelData
    screen: modelData

		exclusionMode: ExclusionMode.Ignore
		WlrLayershell.layer: WlrLayer.Overlay
		WlrLayershell.keyboardFocus: WlrKeyboardFocus.Exclusive

    color: "transparent"
    Image {
      id: name
      source: Qt.resolvedUrl("../../assets/pics/wallpaper.png")
      anchors.fill: parent
      layer.enabled: true
      layer.effect: MultiEffect {
        source: name
        blurEnabled: true
        autoPaddingEnabled: false
        blurMax: 80
        blur: 0.5
      }
    }

    anchors { top: true; left: true; bottom: true; right: true }

    Rectangle {
      color: root.backgroundColor
      anchors.fill: parent

      MouseArea {
        anchors.fill: parent
        onClicked: Qt.quit()

        RowLayout {
          id: grid
          anchors.centerIn: parent
          width: parent.width * 0.85
          height: parent.height * 0.45
          spacing: 10

          Keys.onPressed: event => {
            if (event.key == Qt.Key_Escape) logoutLoader.active = false;
            else {
              for (let i = 0; i < root.buttons.length; i++) {
                let button = root.buttons[i];
                if (event.key == button.keybind) button.exec();
              }
            }
          }

          Repeater {
            id: repeater
            model: root.buttons

            delegate: Rectangle {
              id: button
              required property LogoutButton modelData;
              required property int index;

              focus: index == 0
              Keys.onLeftPressed: {
                if (index > 0) {
                  repeater.itemAt(index - 1).forceActiveFocus()
                } else if (index == 0) {
                  repeater.itemAt(repeater.count - 1).forceActiveFocus()
                }
              }
              Keys.onRightPressed: {
                if (index < repeater.count - 1) {
                  repeater.itemAt(index + 1).forceActiveFocus()
                } else if (index == repeater.count - 1) {
                  repeater.itemAt(0).forceActiveFocus()
                }
              }
              Keys.onReturnPressed: {
                button.modelData.exec()
              }

              MouseArea {
                anchors.fill: parent
                hoverEnabled: true
                onEntered: button.forceActiveFocus()
                onClicked: {
                  button.modelData.exec()
                }
              }

              color: activeFocus ? root.buttonHoverColor : root.buttonColor
              border.color: "white"
              border.width: 3
              radius: 5
              Layout.fillWidth: true
              Layout.fillHeight: true
              implicitWidth: grid.width / 5 - 10
              implicitHeight: grid.height

              // FIX: For some reason this doesn't work: Icons are wrong
              //MaterialIcon {
              //  id: icon
              //  text: button.modelData.icon
              //  font.pointSize: 75
              //  anchors.centerIn: parent
              //}
              IconImage {
                id: icon
                source: Qt.resolvedUrl(`../../assets/pics/${button.modelData.icon}`)
                implicitSize: button.width * 0.25
                anchors.centerIn: parent
                layer.enabled: true
                layer.effect: MultiEffect {
                  colorization: 1.0
                  colorizationColor: button.activeFocus ? "black" : "white"
                }
              }

              Text {
                anchors {
                  top: icon.bottom
                  topMargin: 20
                  horizontalCenter: parent.horizontalCenter
                }
                text: button.modelData.text
                font.pointSize: Appearance.font.size.large
                font.family: Appearance.font.family.mono
                color: button.activeFocus ? "black" : "white"
              }
            }
          }
        }
      }
    }
  }
}
