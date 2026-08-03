{
  inputs,
  ...
}:
{
  flake-file = {
    inputs = {
      flake-file.url = "github:vic/flake-file";
      callpackage-tree = {
        url = "github:bitbloxhub/callpackage-tree";
        flake = false;
      };
      flake-parts = {
        url = "github:hercules-ci/flake-parts";
        inputs.nixpkgs-lib.follows = "nixpkgs";
      };
    };
    outputs =
      # nix
      ''
        inputs:
        inputs.flake-parts.lib.mkFlake { inherit inputs; } (
          ((inputs.import-tree.filterNot (inputs.nixpkgs.lib.hasSuffix "npins/default.nix")).filterNot (
            inputs.nixpkgs.lib.hasSuffix ".pkg.nix"
          )) ./nix
        )
      '';
  };

  imports = [
    inputs.flake-file.flakeModules.default
    inputs.flake-file.flakeModules.import-tree
    (import inputs.callpackage-tree {
      root = ../nix;
    })
  ];

  systems = [
    "x86_64-linux"
    "aarch64-linux"
    "x86_64-darwin"
    "aarch64-darwin"
  ];
}
