{ pkgs, config, lib, ... }:

{
  programs.yazi = {
    enable = true;
    settings = {
      manager = {
        show_hidden = false;
        show_symlink = false; # This is handled by the function in init.lua
        ratio = [ 2 3 5 ];
        linemode = "size";
        scrolloff = 15;
      };
    };
  };

  home.file.".config/yazi/theme.toml".source = ./theme.toml;
  home.file.".config/yazi/keymap.toml".source = ./keymap.toml;
  home.file.".config/yazi/plugins".source = ./plugins;
  home.file.".config/yazi/init.lua".source = ./init.lua;
}
