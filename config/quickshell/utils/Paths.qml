pragma Singleton

import Quickshell
import Qt.labs.platform

Singleton {
  id: root

  readonly property url config: `${StandardPaths.standardLocations(StandardPaths.GenericConfigLocation)[0]}/quickshell`
}
