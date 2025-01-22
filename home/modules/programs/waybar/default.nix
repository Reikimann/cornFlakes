{ config, lib, ... }:

with lib;
let
  cfg = config.reiki.modules.programs.waybar;
in
{
  # TODO: Maybe make a folder for desktop stuff (not /home/desktops) like bars and lockscreens
  options.reiki.modules.programs.waybar = {
    enable = mkEnableOption "Waybar configuration";
    isLaptop = mkOption {
      description = "Switch for adding laptop modules";
      default = false;
      type = types.bool;
    };
    outputScreen = mkOption {
      description = "Output screen";
      default = "eDP-1"; # Laptop screen
      type = types.str;
    };
  };

  config = mkIf cfg.enable {
    programs.waybar = {
      enable = true;
      systemd.enable = true;
      settings = [
        {
          output = cfg.outputScreen;
          layer = "top"; # Waybar at top layer
          position = "top"; # Waybar position (top|bottom|left|right)
          exclusive = true;
          height = 40; # Waybar height (to be removed for auto height)
          # width = 1280; # Waybar width
          spacing = 4; # Gaps between modules (4px)

          include = [ "~/.config/waybar/common-modules.jsonc" ];
          "custom/swww" = {
            format = "{icon}";
            format-icons = {
              default = "";
            };
            tooltip = false;
            on-click = "swww_changebg";
          };

          modules-left = [
            "custom/launcher"
            "hyprland/workspaces"
            "group/system-container"
          ] ++ (if cfg.isLaptop then [
            "custom/updates" # FIX: This should be removed when the laptop doesn't have arch
          ] else []);

          modules-center = [ "clock" ];

          modules-right = [
            "tray"
            "wireplumber"
          ] ++ (if cfg.isLaptop then [
            "backlight"
            "network"
            "battery"
          ] else []) ++ [
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
