pragma Singleton

import Quickshell
import QtQuick

Singleton {
  id: root

  readonly property CustomFonts font: CustomFonts {}

  component FontFamily: QtObject {
    readonly property string mono: "Liga SFMono Nerd Font"
    readonly property string icons: "Material Icons Round"
  }

  component FontSize: QtObject {
    readonly property int small: 11
    readonly property int smaller: 12
    readonly property int normal: 13
    readonly property int larger: 15
    readonly property int large: 18
    readonly property int extraLarge: 28
  }

  component CustomFonts: QtObject {
    readonly property FontFamily family: FontFamily {}
    readonly property FontSize size: FontSize {}
  }
}
