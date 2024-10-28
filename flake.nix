{
  description = "I've nixed any chance I've ever had at human interaction by building this config.";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    ragenix = {
      url = "github:yaxitech/ragenix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    pre-commit-hooks = {
      url = "github:cachix/git-hooks.nix";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.nixpkgs-stable.follows = "nixpkgs"; # who tf cares about stability?
    };
    grub2-themes = {
      url = "github:vinceliuice/grub2-themes";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    flake-parts = {
      url = "github:hercules-ci/flake-parts";
      inputs.nixpkgs-lib.follows = "nixpkgs";
    };
    nixos-generators = {
      url = "github:nix-community/nixos-generators";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    darwin = {
      url = "github:LnL7/nix-darwin/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-monitored = {
      url = "github:ners/nix-monitored";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    wakatime-lsp = {
      url = "github:mrnossiom/wakatime-lsp";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        gitignore.follows = "pre-commit-hooks/gitignore";
        rust-overlay.follows = "ragenix/rust-overlay";
      };
    };
  };

  outputs =
    inputs:
    inputs.flake-parts.lib.mkFlake { inherit inputs; } {
      systems = [
        "x86_64-linux"
        "aarch64-darwin"
      ];
      imports = [
        ./profiles/flake-module.nix
        ./packages/flake-module.nix
        ./hosts/flake-module.nix
        ./dev/flake-module.nix
        inputs.pre-commit-hooks.flakeModule
      ];

      perSystem =
        {
          config,
          pkgs,
          system,
          inputs',
          ...
        }:
        {
          _module.args.pkgs = import inputs.nixpkgs {
            inherit system;
            config.allowUnfree = true;
          };

          pre-commit.settings.hooks = {
            nixfmt-rfc-style.enable = true;
            nil.enable = true;
            deadnix.enable = true;
            statix.enable = true;
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

      flake = {
        nixosModules.dogu = import ./modules/hosts/nixos.nix;
        darwinModules.dogu = import ./modules/hosts/darwin.nix;
        homeManagerModules.dogu = import ./modules/home-manager;

        nixosConfigurations = {
          nebula = inputs.nixpkgs.lib.nixosSystem {
            system = "x86_64-linux";
            specialArgs = {
              inherit inputs;
            };
            modules = [ ./hosts/nebula ];
          };
        };
        darwinConfigurations = {
          dou-mek = inputs.darwin.lib.darwinSystem {
            system = "aarch64-darwin";
            specialArgs = {
              inherit inputs;
            };
            modules = [ ./hosts/m1 ];
          };
        };
      };
    };
}
