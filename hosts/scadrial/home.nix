{ pkgs, config, outputs, ... }:

{
  monitors = [
    {
      name = "eDP-1";
      width = 1920;
      height = 1080;
      refreshRate = 60;
      position = "auto"; # Auto is for hyprland. Can also use e.g. 0x0.
      primary = true;
      enabled = true;
    }
    {
      # https://wiki.hyprland.org/FAQ/#workspaces-or-clients-are-disappearing-or-monitor-related-dispatchers-cause-crashes
      name = "Unknown-1";
      enabled = false;
    }
  ];

  reiki = {
    profiles = {
      common.enable = true;
      desktop = {
        enable = true;
        laptop = true;
      };
      development.enable = true;
      entertainment.enable = true;
      extended.enable = true;
      productivity.enable = true;
    };
    modules = {
      desktop = {
        quickshell.enable = true;
      };
    };
  };

  home.packages = with pkgs; [
     adwaita-icon-theme
     papirus-icon-theme
     pkgs.material-symbols
  ];

  fonts.fontconfig.enable = true;

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  home.stateVersion = "25.05";

  # TODO: Add below to mkHome (see EdenEast/nyx)
  home = {
    username = "reikimann";
    homeDirectory = "/home/reikimann";
  };

  targets.genericLinux.enable = true;
  xdg.systemDirs.data = [ "${config.home.homeDirectory}/.nix-profile/share/applications" ];

  nixpkgs = {
    overlays = outputs.overlays;
    config = import ../../nix/config.nix;
  };

  nix = {
    package = pkgs.nix;
    settings.experimental-features = [ "nix-command" "flakes" ];
  };
}
