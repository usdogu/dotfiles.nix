{ pkgs, inputs, ... }:
{
  imports = [ inputs.home-manager.nixosModules.default ];
  users = {
    mutableUsers = false;
    users.dogu = {
      isNormalUser = true;
      extraGroups = [
        "wheel"
        "networkmanager"
        "video"
        "audio"
        "libvirtd"
        "podman"
      ];
      shell = pkgs.fish;
    };
  };
  programs.fish.enable = true;

  home-manager = {
    useGlobalPkgs = true;
    extraSpecialArgs = {
      inherit inputs;
    };
    users.dogu = import ./home;
  };
}
