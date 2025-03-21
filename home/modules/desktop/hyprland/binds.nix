{ config, lib, pkgs, inputs, ... }:

with lib;
let
  # binds $mainMod + [shift +] {1..10} to [move to] {1..10}
  workspaces = builtins.concatLists (builtins.genList (
    x: let
      ws = let
        c = (x + 1) / 10;
      in
        builtins.toString (x + 1 - (c * 10));
    in [
      "$mainMod, ${ws}, workspace, ${toString (x + 1)}"
      "$mainMod SHIFT, ${ws}, movetoworkspacesilent, ${toString (x + 1)}"
    ]) 10);
in
{
  wayland.windowManager.hyprland.settings = {
    binds = {
      allow_workspace_cycles = true;
    };

    "$mainMod" = "SUPER";

    bindm = [
      # Move/resize windows with mainMod + LMB/RMB and dragging
      "$mainMod, mouse:272, movewindow"
      "$mainMod, mouse:273, resizewindow"
    ];

    bind = let
      discord = lib.getExe pkgs.discord;
      zen-browser = lib.getExe inputs.zen-browser.packages."${pkgs.system}".default;
      hyprpicker = lib.getExe pkgs.hyprpicker;
      hyprshot = lib.getExe pkgs.hyprshot;
      keepassxc = lib.getExe pkgs.keepassxc;
      kitty = lib.getExe pkgs.kitty;
      nemo = lib.getExe pkgs.nemo;
      rofi = lib.getExe pkgs.rofi-wayland;
      spotify = lib.getExe pkgs.spotify;
    in [
      # compositor commands
      "$mainMod, W, killactive"
      "$mainMod CONTROL, q, exit"
      "$mainMod, P, pseudo # dwindle"
      "$mainMod CONTROL, j, togglesplit" # dwindle
      "$mainMod, V, togglefloating"
      "$mainMod SHIFT, c, fullscreen,0"
      "$mainMod, T, togglegroup"
      "$mainMod, Tab, changegroupactive, f"
      "$mainMod SHIFT, Tab, changegroupactive, b"
      "$mainMod, n, workspace, previous"

      # Misc programs
      "$mainMod,Return,exec,${kitty}"
      "$mainMod,B,exec,${zen-browser}"
      "$mainMod,U,exec,${spotify}"
      "$mainMod,Y,exec,${rofi} -show drun"
      "$mainMod,f,exec,${nemo}"
      "$mainMod,d,exec,${discord}"
      "$mainMod,dead_diaeresis,exec,${keepassxc}"
      #"$mainMod,e,exec, emacs"

      # Screenshotting
      "CTRL,Print,exec,${hyprshot} -m region -f $(date '+%Y-%m-%d-%T').png"
      ",Print,exec,${hyprshot} -m region --clipboard-only"

      # Colorpicking
      "SHIFT,Print,exec,${hyprpicker} -a --format=hsl"

      # Move focus with mainMod + vim keys
      "$mainMod, l, movefocus, l"
      "$mainMod, h, movefocus, r"
      "$mainMod, k, movefocus, u"
      "$mainMod, j, movefocus, d"
      "$mainMod, Space, cyclenext"

      # Move window within workspace with mainMod + vim keys
      "$mainMod SHIFT, h, movewindow, l"
      "$mainMod SHIFT, l, movewindow, r"
      "$mainMod SHIFT, k, movewindow, u"
      "$mainMod SHIFT, j, movewindow, d"

      # special workspace(scratchpad)
      "$mainMod, minus, movetoworkspace, special"
      "$mainMod, plus, togglespecialworkspace"

      # layout toggle
      "$mainMod CONTROL, d, exec, hyprctl keyword general:layout dwindle"
      "$mainMod CONTROL, m, exec, hyprctl keyword general:layout master"
    ] ++ (let
      killall = lib.getExe pkgs.killall;
    in optionals config.programs.waybar.enable [
      # Display Waybar
      "$mainMod,O,exec,${killall} -SIGUSR1 .waybar-wrapped"
    ]) ++ (let
      wlogout = lib.getExe pkgs.wlogout;
    in optionals config.programs.wlogout.enable [
      # Display logout menu
      "$mainMod CONTROL,l,exec,${wlogout} --buttons-per-row 5 --margin-top 400 --margin-bottom 400 --show-binds --protocol layer-shell"
    ]) ++ workspaces;

    # Flags:
    # - e for repeat
    # - l for locked/input inhibitor
    # - m for mouse
    # Docs: https://wiki.hyprland.org/Configuring/Binds/#bind-flags
    binde = let
      brightnessctl = lib.getExe pkgs.brightnessctl;
    in [
      # Brightness
      ",XF86MonBrightnessUp,exec,${brightnessctl} s 5%+"
      ",XF86MonBrightnessDown,exec,${brightnessctl} s 5%-"
    ];

    bindel = let
      wpctl = lib.getExe' pkgs.wireplumber "wpctl";
    in [
      # Volume
      ",XF86AudioRaiseVolume,exec,${wpctl} set-volume @DEFAULT_SINK@ 2%+"
      ",XF86AudioLowerVolume,exec,${wpctl} set-volume @DEFAULT_SINK@ 2%-"
    ];

    bindl = let
      wpctl = lib.getExe' pkgs.wireplumber "wpctl";
    in [
      # Volume
      ",XF86AudioMute,exec,${wpctl} set-mute @DEFAULT_SINK@ toggle"
      ",XF86AudioMicMute,exec,${wpctl} set-mute @DEFAULT_SOURCE@ toggle"
    ] ++ (let
      playerctl = lib.getExe' config.services.playerctld.package "playerctl";
      playerctld = lib.getExe' config.services.playerctld.package "playerctld";
    in optionals config.services.playerctld.enable [
      # Audio
      ",XF86AudioNext,exec,${playerctl} next"
      ",XF86AudioPrev,exec,${playerctl} previous"
      ",XF86AudioPlay,exec,${playerctl} play-pause"

      "SHIFT,XF86AudioNext,exec,${playerctld} shift"
      "SHIFT,XF86AudioPrev,exec,${playerctld} unshift"

      "$mainMod,right,exec,${playerctl} next"
      "$mainMod,left,exec,${playerctl} previous"
      "$mainMod CONTROL,space,exec,${playerctl} play-pause"
    ]);
  };
}
