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
      signing = {
        format = "ssh";
        signByDefault = true;
        key = "~/.ssh/id_ed25519.pub";
      };
      difftastic = {
        enable = true;
        background = "dark";
      };
      extraConfig = {
        credential.helper = "store";
        init.defaultBranch = "main";
        url = {
          "https://github.com/".insteadOf = "github:";
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

    programs.jujutsu = {
      enable = true;
      settings = {
        user = {
          name = "Doğu Us";
          email = "uspro@disroot.org";
        };
        ui = {
          diff.tool = [
            (lib.getExe pkgs.difftastic)
            "--color=auto"
            "--background=dark"
            "--display=side-by-side"
            "$left"
            "right"
          ];
        };
        signing = {
          sign-all = true;
          backend = "ssh";
          key = "~/.ssh/id_ed25519.pub";
        };
      };
    };
  };
}
