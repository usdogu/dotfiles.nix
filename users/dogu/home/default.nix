{ inputs, pkgs, ... }:
{
  imports = [ inputs.self.homeManagerModules.dogu ];
  home.stateVersion = "24.05";
  systemd.user.startServices = "sd-switch";

  home.packages = with pkgs; [
    ripgrep
    fd
    wget
    lsd
    rm-improved
    tealdeer
    htop-vim
    jaq # alternative for jq
    home-manager
    fzf
    gh
    bun
  ];

  programs = {
    bat = {
      enable = true;
      extraPackages = [ pkgs.bat-extras.batman ];
    };
    command-not-found.enable = false;
  };

  dogu = {
    git.enable = true;
    shell.enable = true;
    editors.enable = true;
    ssh.enable = true;
  };
}
