{ pkgs, ... }:

# gamemoderun gamescope -f -r 75 -o 25 -- env MANGOHUD=1 %command% 
# If OpenGL game: gamemoderun gamescope -f -r 75 -o 25 -- mangohud --dlsym %command%
{
  programs.steam.enable = true;

  # TODO: Figure out why and how to use:
  programs.steam.gamescopeSession.enable = true;

  environment.systemPackages = with pkgs; [
    mangohud
  ];
  programs.gamemode.enable = true;
}
