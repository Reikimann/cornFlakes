{ pkgs, config, outputs, ... }:

{
  reiki = {
    profiles = {
      common.enable = true;
      development.enable = true;
    };
    modules = { };
  };

  xdg.portal.extraPortals = [pkgs.xdg-desktop-portal-gtk];

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
