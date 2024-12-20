{ pkgs, config, ... }:
let
  startupScript = pkgs.pkgs.writeShellScriptBin "autostart" ''
    # Sets Cursor Theme
    hyprctl setcursor Breeze_Snow 16

    # https://github.com/swaywm/sway/wiki/GTK-3-settings-on-Wayland
    # Sets cursor theme in gtk apps
    gsettings set org.gnome.desktop.interface cursor-theme "$(grep 'gtk-cursor-theme-name' ~/.config/gtk-3.0/settings.ini | sed 's/.*\s*=\s*//')"

    # Starts the NetworkManager applet (This should only be done on laptop. Use modules to fix...)
    nm-applet 2>&1 > /dev/null &

    # Manage Lockscreen
    ~/.local/bin/lockidle &

    # Manage Clipboard
    wl-paste -t text --watch clipman store --no-persist &
  '';
in
{
  # TODO: Setup hyprpicker https://github.com/hyprwm/hyprpicker
  wayland.windowManager.hyprland = {
    enable = true;
    settings = {
      source = [
        "~/.config/hypr/binds.conf"
        "~/.config/hypr/windowrules.conf"
        "~/.config/hypr/input.conf"
      ];

      # TODO: Make this work on laptop also
      monitor = [
        "DP-2,2560x1440@240,auto,1"
        # https://wiki.hyprland.org/FAQ/#workspaces-or-clients-are-disappearing-or-monitor-related-dispatchers-cause-crashes
        "Unknown-1,disabled"
      ];

      #monitor = ",preferred,auto,1";

      general = {
        layout = "master"; # master|dwindle

        border_size = 2;
        gaps_in = 5;
        gaps_out = 10;

        resize_on_border = true;
        hover_icon_on_border = false;

        # col.active_border = rgba(5d00baff) rgba(bb9af7ff) rgba(7d40efff) 45deg # #5d00ba #bb9af7 #7d40ef
        "col.active_border" = "rgba(5d00baff) rgba(5E172Aff) rgba(7d40efff) 45deg"; # #5d00ba #bb9af7 #7d40ef
        # col.active_border = rgb(5d00ba) rgb(5E172A) rgb(5d00ba) 50deg # #5d00ba #5E172A #5d00ba
        # col.active_border = rgba(5d00ba99) rgba(5E172A99) rgba(5d00ba99) 50deg # #5d00ba #5E172A #5d00ba a bit transparent
        "col.inactive_border" = "rgba(33333311)"; # #333333
      };

      # Blurs
      # layerrule = "blur,gtk-layer-shell";
      layerrule = "blur,logout_dialog";

      decoration = {
        # See https://wiki.hyprland.org/Configuring/Variables/ for more
        rounding = 5;

        blur = {
          enabled = true;
          size = 3;
          passes = 3; # higher looks better, bad for performance, tho
          new_optimizations = true;
          xray = true; #floating windows will ignore tiled windows in their blur.
        };

        active_opacity = 1.0;
        inactive_opacity = 1.0;
        fullscreen_opacity = 1.0;

        drop_shadow = false;
        shadow_range = 10;
        shadow_render_power = 3;
        "col.shadow" = "rgba(1a1a1aee)";
      };

      #animation=NAME,ONOFF,SPEED,CURVE,(STYLE)
      # global
      #   ↳ windows - styles: slide, popin
      #     ↳ windowsIn - window open
      #     ↳ windowsOut - window close
      #     ↳ windowsMove - everything in between, moving, dragging, resizing.
      #   ↳ fade
      #     ↳ fadeIn - fade in (open) -> layers and windows
      #     ↳ fadeOut - fade out (close) -> layers and windows
      #     ↳ fadeSwitch - fade on changing activewindow and its opacity
      #     ↳ fadeShadow - fade on changing activewindow for shadows
      #     ↳ fadeDim - the easing of the dimming of inactive windows
      #   ↳ border - for animating the border's color switch speed
      #   ↳ borderangle - for animating the border's gradient angle - styles: once (default), loop
      #   ↳ workspaces - styles: slide, slidevert, fade
      #     ↳ specialWorkspace - styles: same as workspaces
      animations = {
        enabled = 1;
        bezier = [
          "overshot, 0.13, 0.99, 0.29, 1.1"
          "liner, 1, 1, 1, 1"
        ];
        animation = [
          "windows, 1, 3, overshot, slide"
          "windowsOut, 1, 3, default, popin 80%"
          "border, 1, 3, default"
          "borderangle, 1, 50, liner, loop"
          "fade, 1, 3, default"
          "workspaces, 1, 3, overshot, slidevert"
        ];
      };

      group = {
        "col.border_active" = "rgba(5d00baff) rgba(5E172Aff) rgba(7d40efff) 45deg"; # #5d00ba #bb9af7 #7d40ef
        "col.border_inactive" = "rgba(33333311)"; # #333333
        groupbar = {
          height = 3;
          render_titles = false;
          "col.active" = "rgba(5d00baff)";
          "col.inactive" = "rgba(7d40ef66)";
        };
      };

      dwindle = {
        pseudotile = true; # Bound to mainMod + P
        preserve_split = true; # You probably want this
        smart_split = true;
        no_gaps_when_only = false;
        special_scale_factor = 0.95; # Scale of special workspaces
      };

      master = {
        new_status = "master"; # could also use slave or inherit
        new_on_top = true;
        no_gaps_when_only = false;
        special_scale_factor = 0.95; # Scale of special workspaces
        mfact = 0.50;
      };

      # See https://wiki.hyprland.org/Configuring/Keywords/#executing for more
      misc = {
        disable_hyprland_logo = true;
        disable_splash_rendering = true;
        # enable_swallow = true;
        # swallow_regex = ^(kitty)$
        close_special_on_empty = true;
        font_family = "Liga SFMono Nerd Font";
      };

      #exec-once = ''${startupScript}/bin/autostart'';
      # TODO: Nixify the choice between desktopBar and laptopBar
      exec-once = [
        ''waybar -b desktopBar &''
        "swww-daemon &"
        "~/.config/swww/swww_randomize.sh $RICE_WALL_DIR &"
      ];
    };
  };

  home.file.".config/hypr/binds.conf".source = ./configs/binds.conf;
  home.file.".config/hypr/input.conf".source = ./configs/input.conf;
  home.file.".config/hypr/windowrules.conf".source = ./configs/windowrules.conf;

  home.packages = with pkgs; [
    hyprshot
  ];

  home.sessionVariables = {
    HYPRSHOT_DIR = "${config.xdg.userDirs.pictures}/screenshots";
  };
}
