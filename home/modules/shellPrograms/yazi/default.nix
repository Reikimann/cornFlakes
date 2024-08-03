{ pkgs, config, lib, ... }:

{
  programs.yazi = {
    enable = true;
    settings = {
      manager = {
        show_hidden = false;
        ratio = [ 2 3 5 ];
        linemode = "size";
      };
    };
  };

  home.file.".config/yazi/theme.toml".source = ./theme.toml;
  home.file.".config/yazi/init.lua".source = ./init.lua;
}
