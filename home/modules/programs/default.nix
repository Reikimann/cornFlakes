{ pkgs, ... }:

{
  imports = [
    ./anytype.nix
    ./kitty.nix
    ./spotify.nix
    ./discord.nix
    ./signal-desktop.nix
    ./zathura.nix
    ./swaylock
    ./rofi
    ./firefox
    ./swww
    ./waybar
    ./wlogout
    ./wofi
  ];

  # Not sorted yet
  home.packages = with pkgs; [
    keepassxc
    brightnessctl
    playerctl
    hyprpicker
    # pkgs.kicad
  ];
}
