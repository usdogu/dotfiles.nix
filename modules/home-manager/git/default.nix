{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.dogu.git;
in
{
  options.dogu.git = {
    enable = lib.mkEnableOption "git";
  };

  config = lib.mkIf cfg.enable {
    programs.git = {
      enable = true;
      userName = "Doğu Us";
      userEmail = "uspro@disroot.org";
      difftastic = {
        enable = true;
        background = "dark";
      };
      signing = {
        key = "A8B0AEA8D751EC27";
        signByDefault = true;
      };
      extraConfig = {
        credential.helper = "store";
        init.defaultBranch = "main";
        url = {
          "https://github.com/".insteadOf = "github:";
          "https://codeberg.org/".insteadOf = "cerg:";
        };
        merge.conflictStyle = "zdiff3";
        push.autoSetupRemote = true;
        fetch = {
          prune = true;
          pruneTags = true;
        };
        rerere = {
          enable = true;
          autoUpdate = true;
        };
      };
    };

    home.packages = [ pkgs.git-open ];
  };
}
