{ pkgs, lib, config, ... }:
{
  home.packages = with pkgs; [
    neofetch
  ];

  home.file.".config/neofetch/config.conf".source = ./config.conf;
}
