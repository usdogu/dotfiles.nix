{
  description = "My nix flake configuration";

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
    };
  };

  outputs = inputs:
    let
      system = "x86_64-linux";
      pkgs = inputs.nixpkgs.legacyPackages.${system};
    in {
      lib = import ./lib inputs;

      nixosConfigurations = import ./hosts inputs;

      packages.${system} = import ./packages inputs;

      devShells.${system}.default = pkgs.mkShellNoCC {
        packages = [ pkgs.nixpkgs-fmt inputs.agenix.packages.${system}.agenix ];
        inherit (inputs.self.checks.${system}.pre-commit-check) shellHook;
      };

      checks.${system}.pre-commit-check =
        inputs.pre-commit-hooks.lib.${system}.run {
          src = ./.;
          hooks.nil.enable = true;
          hooks.nixfmt.enable = true;
        };

    };
}
