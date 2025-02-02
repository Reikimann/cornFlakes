{ config, lib, pkgs, ... }:

with lib;
let
  cfg = config.reiki.modules.desktop.cursor;
in
{
  options.reiki.modules.desktop.cursor = {
    enable = mkEnableOption "Cursor configuration";
    size = mkOption {
      description = "Determines the size of the cursor";
      default = 20;
      type = types.int;
    };
  };

  config = mkIf cfg.enable {
    home.pointerCursor = {
      gtk.enable = true;
      x11.enable = true;
      name = "Bibata-Modern-Ice";
      package = pkgs.bibata-cursors;
      size = cfg.size;
    };
  };
}
