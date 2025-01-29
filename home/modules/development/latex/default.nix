{ config, lib, ... }:

with lib;
let
  cfg = config.reiki.modules.development.latex;
in
{
  options.reiki.modules.development.latex = {
    enable = mkEnableOption "LaTeX configuration";
  };

  config = mkIf cfg.enable {
    programs.texlive = {
      enable = true;
      extraPackages = tpkgs: { inherit (tpkgs) collection-fontsrecommended scheme-full; };
    };

    home.file.".config/latexmk/latexmkrc".source = ./latexmkrc;
  };
}
