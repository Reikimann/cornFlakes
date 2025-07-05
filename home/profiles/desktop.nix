{ config, lib, pkgs, ... }:

with lib;
let
  cfg = config.reiki.profiles.desktop;
  laptopPkgs = with pkgs; [
    networkmanagerapplet # NOTE: wpa_supplicant(_gui) may be needed sometime
  ];
in
{
  options.reiki.profiles.desktop = {
    enable = mkEnableOption "Desktop profile";
    laptop = mkOption {
      description = "Enables various laptop configuration and pkgs";
      default = false;
      type = types.bool;
    };
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      nemo
      brightnessctl
    ] ++ optionals cfg.laptop laptopPkgs;

    isLaptop = cfg.laptop;

    home.file."${config.xdg.userDirs.pictures}/wallpapers".source = ../../wallpapers;
    home.sessionVariables = {
      RICE_WALL_DIR = "${config.xdg.userDirs.pictures}/wallpapers/rices/tokyonight";
    };

    reiki.modules = {
      desktop = {
        cursor.enable = true;
        dunst.enable = true;
        hyprland.enable = true;
        hyprshot.enable = true;
        playerctl.enable = true;
        rofi.enable = true;
        swaylock.enable = true;
        swww.enable = true;
        waybar.enable = true;
        wlogout.enable = true;
        wlsunset.enable = true;
        wofi.enable = false;
      };
      programs = {
        anytype.enable = true;
        discord.enable = true;
        element-desktop.enable = true;
        kitty.enable = true;
        keepassxc.enable = true;
        lunatask.enable = true;
        signal-desktop.enable = true;
        spotify.enable = true;
        zen-browser = {
          enable = true;
          isDefaultBrowser = true;
        };
      };
      digital-wellbeing = {
        bedtime-control.enable = true;
        eye-health.enable = true;
        remember-moving.enable = true;
      };
    };
  };
}
