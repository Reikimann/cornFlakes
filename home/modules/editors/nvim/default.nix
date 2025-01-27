{ config, lib, pkgs, ... }:

with lib;
let
  cfg = config.reiki.modules.editors.nvim;
in
{
  options.reiki.modules.editors.nvim = {
    enable = mkEnableOption "Neovim configuration";
  };

  # TODO: Setup https://github.com/stevearc/conform.nvim (eslint issues?) eller
  # https://github.com/nvimtools/none-ls.nvim (nok mest conform?)
  # TODO: Setup https://github.com/kevinhwang91/nvim-ufo
  # TODO: Try nil lang server instead
  config = mkIf cfg.enable {
    programs.neovim = {
      enable = true;
      #package = pkgs-unstable.neovim;
      defaultEditor = true; # TODO: Make a nix module for chosing a default editor (1)
      viAlias = true;
      vimAlias = true;
      vimdiffAlias = true;
      withPython3 = true;
      withNodeJs = true;
      extraPackages = with pkgs; [
        gcc # needed for nvim-treesitter
        cmake # for telescope
        ripgrep # for telescope
        fzf # for telescope
        python3
        tree-sitter
        tree-sitter-grammars.tree-sitter-latex
      ];
    };
    home.packages = with pkgs; [
      nixd
      pyright
      gopls
      lua-language-server
      astro-language-server
      tailwindcss-language-server
      nodePackages_latest.vscode-langservers-extracted
      nodePackages_latest.typescript-language-server
    ];

    # TODO: Make a nix module for chosing a default editor (2)
    home.sessionVariables = {
      VISUAL = "nvim";
    };

    home.file.".config/nvim/init.lua".source = ./init.lua;
    home.file.".config/nvim/lua".source = ./lua;
  };
}
