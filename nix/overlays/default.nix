# https://github.com/Misterio77/nix-starter-configs/blob/main/standard/overlays/default.nix
# https://github.com/EdenEast/nyx/blob/main/nix/overlays/default.nix

#{ inputs, ... }: {
#  additions = final: _prev: import ../pkgs final.pkgs;
#}
[
  (import ./flameshot)
]
