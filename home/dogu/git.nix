{ pkgs, ... }:

{
  programs.git = {
    enable = true;
    userName = "Doğu Us";
    userEmail = "uspro@disroot.org";
    delta = {
      enable = true;
      options = { side-by-side = true; };
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
