{ config, lib, pkgs, ... }:

with lib;
let
  cfg = config.reiki.modules.cli.yazi;
in
{
  options.reiki.modules.cli.yazi = {
    enable = mkEnableOption "Yazi configuration";
  };

  config = mkIf cfg.enable {
    programs.yazi = {
      enable = true;
      settings = {
        mgr = {
          show_hidden = false;
          show_symlink = false; # This is handled by the function in init.lua
            ratio = [ 2 3 5 ];
          linemode = "size";
          scrolloff = 15;
        };
      };
      plugins = {
        inherit (pkgs.yaziPlugins) full-border;
      };
    };

    home.file.".config/yazi/theme.toml".source = ./theme.toml;
    home.file.".config/yazi/keymap.toml".source = ./keymap.toml;
    home.file.".config/yazi/init.lua".source = ./init.lua;
  };
}
