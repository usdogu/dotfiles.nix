{ ... }:

{
  home.stateVersion = "23.05";
  imports =
    [ ./packages.nix ./programs.nix ./editors.nix ./git.nix ./shell.nix ];
}
