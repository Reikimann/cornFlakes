import "../config"
import QtQuick

Text {
  property real fill

  font.family: Appearance.font.family.icons
  font.pointSize: Appearance.font.size.larger
  font.variableAxes: ({
    FILL: fill.toFixed(1)
  })
}
