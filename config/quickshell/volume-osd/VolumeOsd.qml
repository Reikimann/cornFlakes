import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Services.Pipewire
import Quickshell.Widgets

Scope {
  id: root

  PwObjectTracker {
    objects: [ Pipewire.defaultAudioSink ]
  }

  Connections {
    target: Pipewire.defaultAudioSink?.audio

    function onVolumeChanged() {
      root.shouldShowOsd = true;
      hideTimer.restart();
    }
  }

  property bool shouldShowOsd: false

  Timer {
    id: hideTimer
    interval: 1000
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
          anchors {
            fill: parent
            leftMargin: 10
            rightMargin: 15
          }

          IconImage {
            implicitSize: 30
            source: Quickshell.iconPath("audio-volume-high-symbolic")
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

              implicitWidth: parent.width * (Pipewire.defaultAudioSink?.audio.volume ?? 0)
              radius: parent.radius
            }
          }

          Item {
            implicitWidth: 37
            Text {
              anchors.verticalCenter: parent.verticalCenter
              anchors.right: parent.right
              text: `${Math.round((Pipewire.defaultAudioSink.audio.volume * 100))}%`
              color: "#ffffff"
            }
          }
        }
      }
    }
  }
}
