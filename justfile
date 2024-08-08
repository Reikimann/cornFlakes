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

# Rebuild and active system from flake using current hostname
deploy:
  sudo nixos-rebuild switch --flake .

# Rebuild system from flake using current hostname (Changes applied after reboot)
deploy-boot:
  sudo nixos-rebuild boot --flake .

# Revert to and deploy system from previous generation
rollback:
  sudo nixos-rebuild --rollback switch

# List alle generations of system profile
history:
  nix profile history --profile /nix/var/nix/profiles/system

# Deploys home-manager flake config using current user
deploy-home:
  home-manager switch --flake .


# TODO: Add cmds for garbage collect and profile generation clean
# https://github.com/ryan4yin/nix-config/blob/main/Justfile
