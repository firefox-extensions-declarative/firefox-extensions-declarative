{
  inputs,
  ...
}:
{
  flake-file.inputs.make-shell = {
    url = "github:nicknovitski/make-shell";
    inputs.flake-compat.follows = "";
  };

  imports = [
    inputs.make-shell.flakeModules.default
  ];

  perSystem =
    {
      pkgs,
      ...
    }:
    {
      make-shells.default = {
        name = "firefox-extensions-declarative";
        packages = [
          pkgs.nixfmt
          pkgs.deadnix
          pkgs.statix
          pkgs.npins
          pkgs.just
          pkgs.tilt
        ];

        shellHook = ''
          export TILT_PORT=5031
        '';
      };
    };
}
