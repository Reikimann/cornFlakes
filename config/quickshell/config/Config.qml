pragma Singleton

import "../utils"
import Quickshell
import Quickshell.Io

Singleton {
  id: root

  property alias osd: adapter.osd

  FileView {
    path: `${Paths.config}/shell.json`
    watchChanges: true
    onFileChanged: reload()
    onAdapterUpdated: writeAdapter()

    JsonAdapter {
      id: adapter

      property JsonObject osd: OsdConfig {}
    }
  }
}

