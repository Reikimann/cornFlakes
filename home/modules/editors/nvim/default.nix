{ pkgs, pkgs-unstable, config, lib, ... }:
{
  # TODO: Setup https://github.com/stevearc/conform.nvim
  programs.neovim = {
    enable = true;
    #package = pkgs-unstable.neovim;
    defaultEditor = true;
    viAlias = true;
    # If needed in the future (prop for lang servers)
    withPython3 = true;
    withNodeJs = false;
    extraPackages = with pkgs; [
      gcc # needed for nvim-treesitter
      cmake # for telescope
      ripgrep # for telescope
      fzf # for telescope
    ];
  };

  home.file.".config/nvim/init.lua".source = ./init.lua;
  home.file.".config/nvim/lua".source = ./lua;
}
