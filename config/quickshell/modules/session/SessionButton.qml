pragma ComponentBehavior: Bound
import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import Quickshell.Io
import "../../config"
import "../../services"
import "../../widgets"


Button {
  id: root

	property color buttonColor: "#1e1e1e00"
	property color buttonHoverColor: "#cba6f7"

  required property string command
  required property string symbol
  required property string label
  required property int keybind

  readonly property var process: Process {
    command: ["sh", "-c", `sleep .3 && ${root.command}`]
  }

  onClicked: {
    process.startDetached();
    GlobalStates.sessionOpen = false
  }

  MouseArea {
    anchors.fill: parent
    cursorShape: Qt.PointingHandCursor
    hoverEnabled: true
    onEntered: {
      root.forceActiveFocus()
    }
    onClicked: {
      root.clicked()
    }
  }

  Keys.onPressed: (event) => {
    if (event.key == keybind) {
      root.clicked();
      event.accepted = true
    }
  }
  Keys.onReturnPressed: {
    root.clicked()
  }

  background: Rectangle {
    color: root.activeFocus ? root.buttonHoverColor : root.buttonColor
    border.color: "white"
    border.width: 3
    radius: Appearance.rounding.normal
    Layout.fillWidth: true
    Layout.fillHeight: true
    implicitWidth: parent.parent.width / 5 - 10
    implicitHeight: parent.parent.height

    Behavior on color {
      ColorAnimation {
        duration: Appearance.anim.durations.small
      }
    }

    ColumnLayout {
      anchors.centerIn: parent
      spacing: Appearance.spacing.large

      MaterialSymbol {
        symbol: root.symbol
        font.pointSize: 75
        Layout.alignment: Qt.AlignHCenter
        color: root.activeFocus ? "black" : "white"
        Behavior on color {
          ColorAnimation {
            duration: Appearance.anim.durations.small
          }
        }
      }


      Text {
        text: root.label
        font.pointSize: Appearance.font.size.large
        font.family: Appearance.font.family.mono
        color: root.activeFocus ? "black" : "white"
        Layout.alignment: Qt.AlignHCenter

        Behavior on color {
          ColorAnimation {
            duration: Appearance.anim.durations.small
          }
        }
      }
    }
  }
}
