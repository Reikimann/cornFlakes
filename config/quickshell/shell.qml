//@ pragma Env QS_NO_RELOAD_POPUP=1

import Quickshell
import "modules/bar"
import "modules/osd"
import "modules/logout" as Logout

ShellRoot {
  //Bar {}
  Osd {}

  LazyLoader { active: true; component: Logout.Wrapper { } }
}
