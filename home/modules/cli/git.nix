{ ... }:
{
  # TODO: Don't want to include email, but its not working otherwise.
  # Setup ssh instead.
  programs.git = {
    enable = true;
    userName = "Reikimann";
    extraConfig = {
      init.defaultBranch = "main";
      credential.helper = "store --file ~/.config/git/.git-credentials";
      safe.directory = "/opt/flutter";
    };
    delta = {
      enable = true;
    };
  };
}
