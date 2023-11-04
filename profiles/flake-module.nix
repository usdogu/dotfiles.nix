{ inputs, ... }: {
  flake.nixosModules = {
    ssh = ./ssh.nix;
    xorg = ./xorg.nix;
    upgrade-diff = ./xorg.nix;
    tailscale = ./tailscale.nix;
    nix-nixpkgs = import ./nix-nixpkgs.nix { inherit inputs; };
  };
}
