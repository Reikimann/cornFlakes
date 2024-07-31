# just is a command runner, Justfile is very similar to Makefile, but simpler.

############################################################################
#
#  Nix commands related to the local machine
#
############################################################################
# https://nixos-and-flakes.thiscute.world/best-practices/simplify-nixos-related-commands


# Hidden default. Outputs available cmds when writing "just".
_default:
  @just --list

# Update all the flake inputs
update:
  nix flake update

# Deploys flake config using current system hostname
deploy:
  sudo nixos-rebuild switch --flake .

# List alle generations of system profile
history:
  nix profile history --profile /nix/var/nix/profiles/system

# Deploys home-manager flake config using current user
deploy-home:
  home-manager switch --flake .


# TODO: Add cmds for garbage collect and profiel generation clean
# https://github.com/ryan4yin/nix-config/blob/main/Justfile
