{ pkgs, ... }:
{
  # TODO: Setup https://github.com/stevearc/conform.nvim
  # TODO: Setup https://github.com/kevinhwang91/nvim-ufo
  # TODO: Try nil lang server instead
  programs.neovim = {
    enable = true;
    #package = pkgs-unstable.neovim;
    defaultEditor = true;
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
    ];
  };
  home.packages = with pkgs; [
    nixd
    pyright
    gopls
    lua-language-server
    nodePackages_latest.vscode-langservers-extracted
    nodePackages_latest.typescript-language-server
  ];

  home.sessionVariables = {
    VISUAL = "nvim";
  };

  home.file.".config/nvim/init.lua".source = ./init.lua;
  home.file.".config/nvim/lua".source = ./lua;
}
