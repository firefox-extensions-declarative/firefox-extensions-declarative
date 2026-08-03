{
  inputs,
  ...
}:
{
  flake-file.inputs.pedantix = {
    url = "github:Swarsel/pedantix/feat/per-file";
    inputs = {
      flake-parts.follows = "flake-parts";
      git-hooks-nix.follows = "git-hooks";
      nixpkgs.follows = "nixpkgs";
      treefmt-nix.follows = "treefmt-nix";
    };
  };

  imports = [
    inputs.pedantix.flakeModules.default
  ];

  perSystem =
    {
      pkgs,
      inputs',
      ...
    }:
    {
      make-shells.default.packages = [
        pkgs.nixfmt
        pkgs.deadnix
        pkgs.statix
        inputs'.pedantix.packages.pedantix
      ];

      treefmt.programs = {
        deadnix.enable = true;
        nixfmt.enable = true;
        pedantix = {
          enable = true;
          excludes = [ "flake.nix" ];
        };
        statix.enable = true;
      };
    };
}
