import QtQuick
import "../../widgets"

Logout {
  LogoutButton {
    text: "Lock[l]"
    command: "swaylock"
    keybind: Qt.Key_L
    icon: "lock.png" // Material icon: lock
  }
  LogoutButton {
    text: "Reboot[r]"
    command: "systemctl reboot"
    keybind: Qt.Key_R
    icon: "restart.png" // Material icon: restart
  }
  LogoutButton {
    text: "Shutdown[s]"
    command: "systemctl poweroff"
    keybind: Qt.Key_S
    icon: "power.png" // Material icon: mode_off_on
  }
  LogoutButton {
    text: "Logout[o]"
    command: "hyprctl dispatch exit 0"
    keybind: Qt.Key_O
    icon: "logout.png" // Material icon: logout
  }
  LogoutButton {
    text: "Suspend[u]"
    command: "systemctl suspend"
    keybind: Qt.Key_U
    icon: "sleep.png" // Material icon: bedtime
  }
}
