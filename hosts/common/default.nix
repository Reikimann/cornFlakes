{ outputs, pkgs, ... }:

{
  nixpkgs = {
    overlays = outputs.overlays;
    config.allowUnfree = true;
  };
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # TODO: Is setting zsh as default smart on multisystem flakes?
  users.defaultUserShell = pkgs.zsh;
  programs.zsh.enable = true;
}
