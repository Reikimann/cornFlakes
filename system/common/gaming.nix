{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    heroic
    prismlauncher
  ];

  programs.steam.enable = true;
  # TODO: Figure out why and how to use:
  #programs.steam.gamescopeSession.enable = true;

  #home.packages = with pkgs; [
  #  mangohud
  #];
  #programs.gamemode.enable = true;
}
