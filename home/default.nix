{ config, pkgs, inputs, self, ... }:

{
  home-manager = {
    useGlobalPkgs = true;
    extraSpecialArgs = { inherit inputs self; };
    users = {
      dogu = {
        home.stateVersion = "22.05";
        imports = [
          ./packages.nix
          ./services.nix
          ./editors.nix
          ./ssh-gpg.nix
          ./git.nix
          ./xorg.nix
          ./shell.nix
          ./gtk-qt.nix
          ./devel.nix
          ./browser.nix
        ];
      };
    };
  };
}
