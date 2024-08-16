{ pkgs, ... }:

{
  programs.git = {
    enable = true;
    userName = "Doğu Us";
    userEmail = "uspro@disroot.org";
    delta = {
      enable = false; # 0.17 fails to compile, good chance to try difftastic
      options = { side-by-side = true; };
    };
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
        "https://github.com/".insteadOf = "gh:";
        "https://codeberg.org/".insteadOf = "cerg:";
      };
    };
  };

  home.packages = [ pkgs.git-open ];
}
