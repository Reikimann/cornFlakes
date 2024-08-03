{ pkgs, lib, config, ... }:
{
  home.packages = with pkgs; [
    neo-cowsay
    lolcat
    fortune
    asciiquarium-transparent
    sl
  ];
}
