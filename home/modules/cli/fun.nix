{ pkgs, ... }:

{
  home.packages = with pkgs; [
    neo-cowsay
    lolcat
    fortune
    asciiquarium-transparent
    unimatrix
    sl
  ];
}
