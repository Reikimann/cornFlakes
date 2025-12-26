{ config, lib, pkgs, ... }:

with lib;
let
  cfg = config.reiki.modules.development.editors.nvim;
in
{
  options.reiki.modules.development.editors.nvim = {
    enable = mkEnableOption "Neovim configuration";
    isDefaultEditor = mkOption {
      description = "Whether or not nvim is the default editor";
      default = true;
      type = types.bool;
    };
  };

  # TODO: Setup https://github.com/stevearc/conform.nvim (eslint issues?) eller
  # https://github.com/nvimtools/none-ls.nvim (nok mest conform?)
  # TODO: Setup https://github.com/kevinhwang91/nvim-ufo
  # TODO: Try nil lang server instead
  config = mkIf cfg.enable {
    programs.neovim = {
      enable = true;
      defaultEditor = cfg.isDefaultEditor;
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
        websocat # for typst-preview
        python3
        tree-sitter
        tree-sitter-grammars.tree-sitter-latex
        # order specific: https://github.com/NixOS/nixpkgs/issues/76486
        clang-tools # for arduino lsp
        clang # for arduino lsp
      ];
    };
    home.packages = with pkgs; [
      nixd
      pyright
      gopls
      tinymist
      lua-language-server
      svelte-language-server
      astro-language-server
      tailwindcss-language-server
      nodePackages_latest.vscode-langservers-extracted
      nodePackages_latest.typescript-language-server
      arduino-language-server
    ];

    home.sessionVariables = mkIf cfg.isDefaultEditor {
      VISUAL = "nvim";
    };

    # It's split up so lazy.nvim can make lazy-lock.json
    xdg.configFile = {
      "nvim/lua" = {
        source = config.lib.file.mkOutOfStoreSymlink "${config.dotfilesPath}/config/nvim/lua";
      };
      "nvim/init.lua" = {
        source = config.lib.file.mkOutOfStoreSymlink "${config.dotfilesPath}/config/nvim/init.lua";
      };
    };
  };
}
