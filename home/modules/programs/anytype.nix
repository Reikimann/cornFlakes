{ config, lib, pkgs, ... }:

with lib;
let
  cfg = config.reiki.modules.programs.anytype;
in
{
  options.reiki.modules.programs.anytype = {
    enable = mkEnableOption "Anytype configuration";
    disableWayland = mkOption {
      description = "Toogle to disable Wayland for Anytype";
      default = false;
      type = types.bool;
    };
  };

  config = mkIf cfg.enable {
    home.packages = [
      (if cfg.disableWayland then
        pkgs.symlinkJoin {
          name = "anytype";
          paths = [ pkgs.anytype ];
          buildInputs = [ pkgs.makeWrapper ];
          postBuild = ''
          wrapProgram $out/bin/anytype \
          --unset NIXOS_OZONE_WL
          '';
        }
      else
        pkgs.anytype)
    ];
  };
}
