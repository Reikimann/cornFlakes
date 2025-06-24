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
  model: Quickshell.screens

  property color backgroundColor: "#1e1e2e99"
	property color buttonColor: "#1e1e1e00"
	property color buttonHoverColor: "#cba6f7"

  default property list<LogoutButton> buttons

  PanelWindow {
    id: w

    property var modelData
    screen: modelData

    exclusiveZone: ExclusionMode.Ignore
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

    contentItem {
      focus: true
      Keys.onPressed: event => {
        if (event.key == Qt.Key_Escape) Qt.quit();
        else {
          for (let i = 0; i < root.buttons.length; i++) {
            let button = root.buttons[i];
            if (event.key == button.keybind) button.exec();
          }
        }
      }
    }

    anchors { top: true; left: true; bottom: true; right: true }

    Rectangle {
      color: root.backgroundColor
      anchors.fill: parent

      MouseArea {
        anchors.fill: parent
        onClicked: Qt.quit()

        GridLayout {
          anchors.centerIn: parent
          width: parent.width * 0.8
          height: parent.height * 0.5

          columns: 5
          columnSpacing: 10

          Repeater {
            model: root.buttons
            delegate: Rectangle {
              id: button
              required property LogoutButton modelData;
              Layout.fillWidth: true
              Layout.fillHeight: true

              color: ma.containsMouse ? root.buttonHoverColor : root.buttonColor
              border.color: "white"
              border.width: 3
              radius: 5

              MouseArea {
                id: ma
                anchors.fill: parent
                hoverEnabled: true
                onClicked: button.modelData.exec()
              }


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
                  colorizationColor: ma.containsMouse ? "black" : "white"
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
                color: ma.containsMouse ? "black" : "white"
              }
            }
          }
        }
      }
    }
  }
}
