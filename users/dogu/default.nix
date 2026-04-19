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
      openssh.authorizedKeys.keys = [
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIBYxJtGGaHmbVHyUP1iTvICusscTmD4YZHI+NeEliTeF"
      ];
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
