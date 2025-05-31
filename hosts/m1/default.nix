{
  pkgs,
  inputs,
  ...
}:

{
  imports = [
    inputs.home-manager.darwinModules.default
    inputs.self.darwinModules.dogu
  ];
  system = {
    stateVersion = 5;
    primaryUser = "dogu";
  };
  networking = {
    hostName = "dou-mek";
    computerName = "Dou's Air";
  };
  security.pam.services.sudo_local.touchIdAuth = true;
  users = {
    users.dogu = {
      name = "dogu";
      home = "/Users/dogu";
      shell = pkgs.fish;
      uid = 501;
    };
    knownUsers = [ "dogu" ];
  };
  ids.gids.nixbld = 30000;
  programs.fish.enable = true;
  fonts.packages = [ pkgs.nerd-fonts.iosevka ];
  dogu = {
    nixSettings.enable = true;
    tailscale.enable = true;
    network.enable = true;
    aerospace.enable = true;
    homebrew = {
      enable = true;
      casks = [
        "cloudflare-warp"
        "stats"
        "alt-tab"
        "appcleaner"
        "iina"
        "orbstack"
        "orion"
        "playcover-community"
        "raycast"
        "rider"
        "telegram"
        "swiftformat-for-xcode"
        "alacritty"
        "hiddenbar"
        "the-unarchiver"
        "ayugram"
        "aldente"
        "shortcat"
        "quickrecorder"
      ];
      masApps = {
        Xcode = 497799835;
        Flow = 1423210932;
        PDFGear = 6469021132;
      };
      taps = [ "lihaoyun6/tap" ];
    };
  };

  home-manager = {
    useGlobalPkgs = true;
    extraSpecialArgs = {
      inherit inputs;
    };
    users.dogu = {
      imports = [
        (inputs.self + /users/dogu/home)
        ./home/dogu
      ];
    };
  };
}
