{
  inputs,
  ...
}:
{
  flake-file = {
    outputs =
      # nix
      ''
        inputs:
        inputs.flake-parts.lib.mkFlake { inherit inputs; } (
          (inputs.import-tree.filterNot (inputs.nixpkgs.lib.hasSuffix "npins/default.nix")) ./nix
        )
      '';
    inputs = {
      flake-file.url = "github:vic/flake-file";
      flake-parts = {
        url = "github:hercules-ci/flake-parts";
        inputs.nixpkgs-lib.follows = "nixpkgs";
      };
      nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
      flint = {
        url = "github:NotAShelf/flint";
        inputs.nixpkgs.follows = "nixpkgs";
      };
    };
  };

  systems = [
    "x86_64-linux"
    "aarch64-linux"
    "x86_64-darwin"
    "aarch64-darwin"
  ];

  imports = [
    inputs.flake-file.flakeModules.default
    inputs.flake-file.flakeModules.import-tree
  ];
}
