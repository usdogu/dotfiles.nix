{
  description =
    "I've nixed any chance I've ever had at human interaction by building this config.";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    agenix = {
      url = "github:ryantm/agenix";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.home-manager.follows = "home-manager";
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
  };

  outputs = inputs:
    inputs.flake-parts.lib.mkFlake { inherit inputs; } {
      systems = [ "x86_64-linux" ];
      imports = [
        ./packages
        ./lib
        ./hosts
        ./devel
        inputs.pre-commit-hooks.flakeModule
      ];

      perSystem = { config, pkgs, inputs', ... }: {
        pre-commit.settings.hooks = {
          nixfmt.enable = true;
          nil.enable = true;
        };
        devShells.default = pkgs.mkShellNoCC {
          packages = [ inputs'.agenix.packages.agenix ];
          shellHook = ''
            ${config.pre-commit.installationScript}
          '';
        };
      };
    };
}
