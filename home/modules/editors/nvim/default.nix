{ pkgs }:
{
  programs.neovim = {
    enable = true;
    extraPackages = with pkgs; [
      gcc # needed for nvim-treesitter
        cmake # for telescope
        ripgrep # for telescope
    ];
  };

  home.
}
