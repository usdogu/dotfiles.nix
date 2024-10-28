{ inputs, ... }:

{
  home.stateVersion = "24.05";
  imports = [
    inputs.self.homeManagerModules.dogu
    ./packages.nix
    ./programs.nix
    ./browser.nix
    ./services.nix
  ];

  dogu = {
    theming.enable = true;
    alacritty.enable = true;
    sway.enable = true;
  };
}
