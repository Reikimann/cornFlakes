{ ... }:

{
  wayland.windowManager.hyprland.settings = {
    # NOTE: Fufexan has a nice way of configuring layerrules
    windowrulev2 = [
      # make Firefox/Zen PiP window floating and sticky
      "float,title:^(Picture-in-Picture)$"
      "pin,title:^(Picture-in-Picture)$"

      # spotify
      "tile,class:^(spotify)$"

      # Idleinhibit
      "idleinhibit focus, class:^(mpv)$"
      "idleinhibit focus, class:^(zen)$, title:^(.*Youtube.*)$"
      "idleinhibit fullscreen, class:^(zen)$"

      # Dim certain floating windows
      #float,center,xdg-desktop-portal-gtk
      "dimaround, class:^(gcr-prompter)$"
      "dimaround, class:^(xdg-desktop-portal-gtk)$ # File Picker GTK"
      "dimaround, class:^(polkit-gnome-authentication-agent-1)$"
      "dimaround, class:^(zen)$, title:^(File Upload)$"

      # Maple
      "tile,class:^(java-lang-Thread)$"
      "float,class:^(java-lang-Thread)$,title:^(###focusableSwingPopup###)$"
      "float,class:^(java-lang-Thread)$,title:^(Maple 2023)$"
      "float,center,class:^(java-lang-Thread)$,title:^(Save As)$"
      "float,center,class:^(java-lang-Thread)$,title:^(Window Close Confirmation)$"

      # Libreoffice
      "tile,class:^(libreoffice.*)$"

      # Geogebra
      "tile,class:^(org-geogebra-desktop-GeoGebra3D),title:^(###focusableSwingPopup###)"
      "tile,title:^(GeoGebra Classic 5)$"

      # EasyEDA
      "tile,class:^(EasyEDA)$"

      # TEST: less sensitive scroll for some windows

      # browser(-based)
      #"scrolltouchpad 0.1, class:^(zen|firefox|chromium-browser|chrome-.*)$"
      # GTK3
      #"scrolltouchpad 0.1, class:^(libreoffice.*)$"
      #"scrolltouchpad 0.1, class:^(.virt-manager-wrapped)$"
      #"scrolltouchpad 0.1, class:^(xdg-desktop-portal-gtk)$"
      # Qt5
      # "scrolltouchpad 0.1, class:^(org.prismlauncher.PrismLauncher)$"
      # "scrolltouchpad 0.1, class:^(org.kde.kdeconnect.app)$"
      # Others
      # "scrolltouchpad 0.1, class:^(org.pwmt.zathura)$"
    ];
  };
}
