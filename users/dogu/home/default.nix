{
  inputs,
  pkgs,
  config,
  ...
}:
{
  imports = [
    inputs.self.homeManagerModules.dogu
    inputs.agenix.homeManagerModules.age
  ];

  home = {
    stateVersion = "25.05";
    sessionVariables.WAKATIME_HOME = "${config.xdg.configHome}/wakatime";
  };

  age.secrets.wakatime-config = {
    file = inputs.self + /secrets/wakatime-config.age;
    path = "${config.xdg.configHome}/wakatime/.wakatime.cfg";
  };

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
