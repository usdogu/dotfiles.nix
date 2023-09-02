{
  description =
    "I've nixed any chance I've ever had at human interaction by building this config.";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    ragenix = {
      url = "github:yaxitech/ragenix";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.flake-utils.follows = "pre-commit-hooks/flake-utils";
    };
    pre-commit-hooks = {
      url = "github:cachix/pre-commit-hooks.nix";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.nixpkgs-stable.follows = "nixpkgs"; # who tf cares about stability?
    };
    grub2-themes = {
      url = "github:AnotherGroupChat/grub2-themes-png";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    flake-parts = {
      url = "github:hercules-ci/flake-parts";
      inputs.nixpkgs-lib.follows = "nixpkgs";
    }; # NOTE: use github:nix-systems if you ever happen to have a chance of using macos
    nixos-generators = {
      url = "github:nix-community/nixos-generators";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs:
    inputs.flake-parts.lib.mkFlake { inherit inputs; } {
      systems = [ "x86_64-linux" ];
      imports = [
        ./profiles/flake-module.nix
        ./packages/flake-module.nix
        ./hosts/flake-module.nix
        ./dev/flake-module.nix
        inputs.pre-commit-hooks.flakeModule
      ];

      perSystem = { config, pkgs, inputs', ... }: {
        pre-commit.settings.hooks = {
          nixfmt.enable = true;
          nil.enable = true;
        };
        devShells.default = pkgs.mkShellNoCC {
          packages = [ inputs'.ragenix.packages.ragenix ];
          shellHook = ''
            ${config.pre-commit.installationScript}
          '';
        };
        packages.iso = inputs.nixos-generators.nixosGenerate {
          system = "x86_64-linux";
          modules = [ ./hosts/iso/default.nix ];
          format = "iso";
        };
      };
    };
}
