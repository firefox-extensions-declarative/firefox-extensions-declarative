{
  perSystem =
    {
      pkgs,
      ...
    }:
    let
      nodejs = pkgs.nodejs_latest;
      pnpm = pkgs.pnpm_10;
      pnpmDeps = pkgs.fetchPnpmDeps {
        inherit src pnpm;
        fetcherVersion = 3; # https://nixos.org/manual/nixpkgs/stable/#javascript-pnpm-fetcherVersion
        hash = "sha256-eg/0Kc/8HmHn9Ns+umluuFL1BDKhhLtCvS3JW5sB/DA=";
        pname = "firefox-extensions-declarative-pnpm-deps";
      };
      src = ../.;
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
        inherit src pnpmDeps;
        buildPhase = ''
          cd docs
          pnpm build
        '';
        installPhase = ''
          cp -r dist $out
        '';
        name = "firefox-extensions-declarative-docs";
        nativeBuildInputs = [
          nodejs
          pnpm
          pkgs.pnpmConfigHook
        ];
      };
    };
}
