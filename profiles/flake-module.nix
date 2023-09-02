{ inputs, ... }: {
  flake.nixosModules = {
    ssh = ./ssh.nix;
    xorg = ./xorg.nix;
    upgrade-diff = ./xorg.nix;
    tailscale = import ./tailscale.nix { inherit inputs; };
    nix-nixpkgs = import ./nix-nixpkgs.nix { inherit inputs; };
  };
}
