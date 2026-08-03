{
  flake-file.inputs.flint = {
    url = "github:NotAShelf/flint";
    inputs.nixpkgs.follows = "nixpkgs";
  };

  perSystem =
    {
      inputs',
      ...
    }:
    {
      make-shells.default.packages = [
        inputs'.flint.packages.default
      ];
    };
}
