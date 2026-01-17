{
  inputs,
  ...
}:
{
  flake-file.inputs = {
    make-shell = {
      url = "github:nicknovitski/make-shell";
      inputs.flake-compat.follows = "";
    };
  };

  imports = [
    inputs.make-shell.flakeModules.default
  ];

  perSystem =
    {
      pkgs,
      inputs',
      ...
    }:
    {
      make-shells.default = {
        name = "firefox-extensions-declarative";
        packages = [
          pkgs.nixfmt
          pkgs.deadnix
          pkgs.statix
          inputs'.flint.packages.default
          pkgs.just
          pkgs.tilt
          pkgs.harper
        ];

        shellHook = ''
          export TILT_PORT=5031
        '';
      };
    };
}
