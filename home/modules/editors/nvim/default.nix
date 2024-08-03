{ pkgs, config, lib, ... }:
{
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    # If needed in the future (prop for lang servers)
    withPython3 = false;
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
