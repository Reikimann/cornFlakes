{ config, lib, pkgs, ... }:

with lib;
let
  cfg = config.reiki.modules.productivity.figma;
in
{
  options.reiki.modules.productivity.figma = {
    enable = mkEnableOption "Figma configuration";
    disableWayland = mkOption {
      description = "Toggle to disable Wayland for Figma";
      default = false;
      type = types.bool;
    };
  };

  config = mkIf cfg.enable {
    home.packages = [
      (if cfg.disableWayland then
        pkgs.symlinkJoin {
        name = "figma-linux";
        paths = [ pkgs.figma-linux ];
        buildInputs = [ pkgs.makeWrapper ];
        postBuild = ''
        wrapProgram $out/bin/figma-linux \
        --unset NIXOS_OZONE_WL
        '';
        }
      else
        pkgs.figma-linux)
    ];
  };
}
