import QtQuick
import QtQuick.Layouts
import QtQuick.Effects
import Quickshell
import Quickshell.Widgets
import "../../services"
import "../../config"
import "../../widgets"

Scope {
  id: root
  property bool shouldShowOsd: false

  function show(): void {
    root.shouldShowOsd = true;
    hideTimer.restart();
  }

  Connections {
    target: Audio

    function onVolumeChanged(): void {
      root.show();
    }
  }

  Timer {
    id: hideTimer
    interval: Config.osd.hideDelay
    onTriggered: root.shouldShowOsd = false
  }

  LazyLoader {
    active: root.shouldShowOsd

    PanelWindow {
      anchors.top: true
      margins.top: screen.height / 100

      implicitWidth: 400
      implicitHeight: 50
      color: "transparent"

      mask: Region {}

      Rectangle {
        anchors.fill: parent
        radius: height / 2
        color: "#80000000"

        RowLayout {
          spacing: 10
          anchors {
            fill: parent
            leftMargin: 10
            rightMargin: 10
          }

          IconImage {
            implicitSize: 18
            source: Qt.resolvedUrl("../../assets/pics/volume-high.svg")
            layer.enabled: true
            layer.effect: MultiEffect {
              colorization: 1.0
              colorizationColor: "white"
            }
          }

          Rectangle {
            Layout.fillWidth: true

            implicitHeight: 10
            radius: 20
            color: "#50ffffff"

            Rectangle {
              anchors {
                left: parent.left
                top: parent.top
                bottom: parent.bottom
              }

              implicitWidth: parent.width * Audio.volume
              radius: parent.radius
            }
          }

          Text {
            text: `${Math.round(Audio.volume * 100)}%`
            color: "#ffffff"
            font.family: Appearance.font.family.mono
            font.pointSize: Appearance.font.size.smaller
          }
        }
      }
    }
  }
}
