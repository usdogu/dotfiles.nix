_: {
  flake.nixosModules = {
    ssh = ./ssh.nix;
    xorg = ./xorg.nix;
    nix-nixpkgs = ./nix-nixpkgs.nix;
    tailscale = ./tailscale.nix;
    netdata = ./netdata.nix;
  };
}
