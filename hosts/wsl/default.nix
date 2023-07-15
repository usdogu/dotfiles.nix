{ pkgs, ... }: {
  wsl = {
    enable = true;
    defaultUser = "dogu";
    wslConf.automount.root = "/mnt";
    startMenuLaunchers = true;
  };
  security.doas.enable = true;
  security.doas.extraRules = [{
    users = [ "dogu" ];
    noPass = true;
    keepEnv = true;
  }];
  users.users.dogu = {
    isNormalUser = true;
    extraGroups = [ "wheel" ];
    shell = pkgs.fish;
  };
  programs.fish = { enable = true; };
  environment.systemPackages = with pkgs; [ git ];
  system.stateVersion = "23.05";
}
