{
  perSystem =
    {
      pkgs,
      ...
    }:
    let
      src = ../.;
      nodejs = pkgs.nodejs_25;
      pnpm = pkgs.pnpm_10;
      pnpmDeps = pkgs.fetchPnpmDeps {
        inherit src pnpm;
        pname = "firefox-extensions-declarative-pnpm-deps";
        hash = "sha256-eg/0Kc/8HmHn9Ns+umluuFL1BDKhhLtCvS3JW5sB/DA=";
        fetcherVersion = 3; # https://nixos.org/manual/nixpkgs/stable/#javascript-pnpm-fetcherVersion
      };
    in
    {
      make-shells.default = {
        packages = [
          nodejs
          pnpm
        ];

        shellHook = ''
          export PATH=$PATH:node_modules/.bin/
        '';
      };

      packages.docs = pkgs.stdenv.mkDerivation {
        name = "firefox-extensions-declarative-docs";
        inherit src pnpmDeps;

        nativeBuildInputs = [
          nodejs
          pnpm
          pkgs.pnpmConfigHook
        ];

        buildPhase = ''
          cd docs
          pnpm build
        '';

        installPhase = ''
          cp -r dist $out
        '';
      };
    };
}
