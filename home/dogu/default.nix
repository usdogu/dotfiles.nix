{ ... }:

{
  home.stateVersion = "23.05";
  imports = [
    ./packages.nix
    ./programs.nix
    ./services.nix
    ./editors.nix
    ./git.nix
    ./shell.nix
  ];
}
