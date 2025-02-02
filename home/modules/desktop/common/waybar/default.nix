{ config, lib, pkgs, ... }:

with lib;
let
  cfg = config.reiki.modules.desktop.waybar;
in
{
  options.reiki.modules.desktop.waybar = {
    enable = mkEnableOption "Waybar configuration";
  };

  config = mkIf cfg.enable {
    programs.waybar = {
      enable = true;
      systemd.enable = true;
      settings = [
        {
          # NOTE: If there is more than one monitor, then _one_ of
          # them will always be marked as the primary.
          output = let
            primaryMonitor = (monitors:
             if builtins.length monitors == 1 then builtins.head monitors
             else builtins.filter (m: m.primary) monitors
            )
            (config.monitors);
          in
            if primaryMonitor == [] then
              throw "No primary monitor found" # This shouldn't be possible (see note above)
            else
              (builtins.head primaryMonitor).name;

          layer = "top"; # Waybar at top layer
          position = "top"; # Waybar position (top|bottom|left|right)
          exclusive = true;
          height = 40; # Waybar height (to be removed for auto height)
          # width = 1280; # Waybar width
          spacing = 4; # Gaps between modules (4px)

          include = [ "~/.config/waybar/common-modules.jsonc" ];
          # FIX: Why doesn't this button work on startup, but only after launching it as a user?
          "custom/swww" = {
            format = "{icon}";
            format-icons = {
              default = "";
            };
            tooltip = false;
            on-click = "${pkgs.swww-utils}/bin/swww-utils switch";
          };

          modules-left = [
            "custom/launcher"
            "hyprland/workspaces"
            "group/system-container"
          ];
          modules-center = [ "clock" ];
          modules-right = [
            "tray"
            "wireplumber"
          ] ++ lib.optionals config.isLaptop [
            "backlight"
            "network"
            "battery"
          ] ++ [
            "custom/swww"
          ];
        }
      ];
    };

    home.file.".config/waybar/colors.css".source = ./colors.css;
    home.file.".config/waybar/style.css".source = ./style.css;
    home.file.".config/waybar/common-modules.jsonc".source = ./common-modules.jsonc;
  };
}
