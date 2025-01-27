{ config, lib, ... }:

with lib;
let
  cfg = config.reiki.modules.shell.bash;
in
{
  options.reiki.modules.shell.bash = {
    enable = mkEnableOption "Bash configuration";
    enableZoxide = mkOption {
      description = "Enables Zoxide integration";
      default = true;
      type = types.bool;
    };
    enableStarship = mkOption {
      description = "Enables Starship integration";
      default = true;
      type = types.bool;
    };
  };

  config = mkIf cfg.enable {
    programs = {
      bash = {
        enable = true;
        enableCompletion = true;
        shellAliases = (import ./aliases.nix).myAliases;
      };

      zoxide = {
        enable = cfg.enableZoxide;
        enableBashIntegration = true;
      };

      # TODO: Find a way to include the configuration
      starship = {
        enable = cfg.enableStarship;
        enableBashIntegration = true;
      };
    };
  };
}
