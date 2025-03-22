{ config, lib, pkgs, ... }:

with lib;
let
  cfg = config.reiki.modules.desktop.hyprland;

  pointer = config.home.pointerCursor;

  # TODO: Use the hyprland utilities for lockscreen and idling
  startupScript = pkgs.pkgs.writeShellScriptBin "autostart" ''
    # Manage Lockscreen
    ~/.local/bin/lockidle &

    # Manage Clipboard
    wl-paste -t text --watch clipman store --no-persist &
  '';
in
{
  options.reiki.modules.desktop.hyprland = {
    enable = mkEnableOption "Hyprland configuration";
  };

  imports = [
    ./binds.nix
    ./input.nix
    ./rules.nix
  ];

  config = mkIf cfg.enable {
    xdg.portal.extraPortals = [pkgs.xdg-desktop-portal-gtk];

    wayland.windowManager.hyprland = {
      enable = true;
      systemd.variables = ["--all"];
      settings = {
        monitor = map
          (m:
            let
              resolution = "${toString m.width}x${toString m.height}@${toString m.refreshRate}";
            in
            "${m.name},${if m.enabled then "${resolution},${m.position},1" else "disable"}"
          )
          (config.monitors);

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

          shadow = {
            enabled = false;
            color = "rgba(1a1a1aee)";
            range = 10;
            render_power = 3;
          };
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
            "linear, 1, 1, 1, 1"
          ];
          animation = [
            "windows, 1, 3, overshot, slide"
            "windowsOut, 1, 3, default, popin 80%"
            "border, 1, 3, default"
            "borderangle, 1, 50, linear, loop"
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
          special_scale_factor = 0.95; # Scale of special workspaces
        };

        master = {
          new_status = "master"; # could also use slave or inherit
          new_on_top = true;
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

        exec-once = [
          "${pkgs.swww}/bin/swww-daemon &"
          "${pkgs.swww-utils}/bin/swww-utils randomize &"
          "hyprctl setcursor ${toString pointer.name} ${toString pointer.size}"
        ];
      };
      extraConfig = ''
        bind=$mainMod ALT,R,submap,resize
        submap=resize

        # sets repeatable binds for resizing the active window
        binde=,l,resizeactive,20 0
        binde=,h,resizeactive,-20 0
        binde=,k,resizeactive,0 -20
        binde=,j,resizeactive,0 20

        bind=,escape,submap,reset
        submap=reset
      '';
    };
  };
}
