{ ... }:

{
  programs.texlive = {
    enable = true;
    extraPackages = tpkgs: { inherit (tpkgs) collection-fontsrecommended scheme-full; };
  };

  home.file.".config/latexmk/latexmkrc".source = ./latexmkrc;
}
