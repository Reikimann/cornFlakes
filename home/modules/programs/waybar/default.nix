{ ... }:

{
  # TODO: Download font awesome for some of the icons
  programs.waybar = {
    enable = true;
    settings = [
      {
        id = "desktopBar";
        output = "DP-1";
        layer = "top"; # Waybar at top layer
        position = "top"; # Waybar position (top|bottom|left|right)
        exclusive = true;
        height = 40; # Waybar height (to be removed for auto height)
        # width = 1280; # Waybar width
        spacing = 4; # Gaps between modules (4px)

        include = [ "~/.config/waybar/common-modules.jsonc" ];

        modules-left = [
          "custom/launcher"
          "hyprland/workspaces"
          "group/system-container"
        ];
        modules-center = [ "clock" ];
        modules-right = [
          "tray"
          "wireplumber"
          "custom/swww"
          "battery"
        ];
        "custom/swww" = {
          format = "{icon}";
          format-icons = {
            default = "";
          };
          tooltip = false;
          on-click = "swww_changebg";
        };
      }
      # TODO: Is this really needed? If the module doesn't work on desktop it's disabled.
      # MAYBE: Remove after laptop is converted to nix (custom/updates)
      {
        id = "laptopBar";
        output = "eDP-1";
        layer = "top"; # Waybar at top layer
        position = "top"; # Waybar position (top|bottom|left|right)
        exclusive = true;
        height = 40; # Waybar height (to be removed for auto height)
        # width = 1280; # Waybar width
        spacing = 4; # Gaps between modules (4px)

        include = [ "~/.config/waybar/common-modules.jsonc" ];

        modules-left = [
          "custom/launcher"
          "hyprland/workspaces"
          "group/system-container"
          "custom/media"
          "custom/updates"
        ];
        modules-center = [ "clock" ];
        modules-right = [
          "tray"
          "backlight"
          "pulseaudio"
          "pulseaudio#microphone"
          "network"
          "custom/swww"
          "battery"
        ];
        "custom/swww" = {
          format = "{icon}";
          format-icons = {
            default = "";
          };
          tooltip = false;
          on-click = "~/.config/swww/swww_changebg.sh";
        };
      }
    ];
  };

  home.file.".config/waybar/colors.css".source = ./colors.css;
  home.file.".config/waybar/style.css".source = ./style.css;
  # TODO: This is not how the scripts should be written. Use nix :)
  home.file.".config/waybar/mediaplayer.py".source = ./mediaplayer.py;
  home.file.".config/waybar/common-modules.jsonc".source = ./common-modules.jsonc;
}
