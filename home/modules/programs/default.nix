{ pkgs, ... }:

{
  imports = [
    ./kitty.nix
    ./spotify.nix
    ./discord.nix
    ./signal-desktop.nix
    ./swaylock
    ./rofi
    ./firefox
    ./waybar
    ./wlogout
    ./wofi
  ];

  # Not sorted yet
  home.packages = [
    pkgs.anytype
    pkgs.keepassxc
  ];
}
