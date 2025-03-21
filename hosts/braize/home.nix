{ pkgs, config, outputs, ... }:

{
  imports = [
    ../../home/modules
    ../../home/profiles
  ];

  monitors = [
    {
      name = "DP-1";
      width = 2560;
      height = 1440;
      refreshRate = 240;
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
      desktop.enable = true;
      development.enable = true;
      entertainment.enable = true;
      extended.enable = true;
      productivity.enable = true;
    };
    modules = {
      programs = {
        anytype.disableWayland = true;
      };
      productivity = {
        figma.disableWayland = true;
      };
    };
  };

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  home.stateVersion = "24.05";

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
