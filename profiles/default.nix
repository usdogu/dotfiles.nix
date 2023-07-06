{ lib, headless, ... }:

{
  imports = [ ./ssh.nix ./nix-nixpkgs.nix ./tailscale.nix ./upgrade-diff.nix ]
    ++ lib.optionals (!headless) [ ./xorg.nix ];
}
