{ pkgs, config, lib, ... }:

with lib;
let
  cfg = config.reiki.modules.programs.lunatask;
in
{
  options.reiki.modules.programs.lunatask = {
    enable = mkEnableOption "Lunatask configuration";
    enableWayland = mkOption {
      description = "Toggle to enable Wayland for Lunatask";
      default = true;
      type = types.bool;
    };
  };

  config = mkIf cfg.enable {
    home.packages = [
      (if cfg.enableWayland then
        pkgs.symlinkJoin {
          name = "lunatask";
          paths = [ pkgs.lunatask ];
          buildInputs = [ pkgs.makeWrapper ];
          postBuild = ''
          wrapProgram $out/bin/lunatask \
          --add-flags "--ozone-platform-hint=auto --enable-features=WaylandWindowDecorations --enable-wayland-ime=true"
          '';
        }
      else
        pkgs.lunatask)
    ];
  };
}
