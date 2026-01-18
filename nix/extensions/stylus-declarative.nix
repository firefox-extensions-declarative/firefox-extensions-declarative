{
  perSystem =
    {
      pkgs,
      ...
    }:
    {
      packages.stylus-declarative =
        let
          nodejs = pkgs.nodejs_25;
          pnpm = pkgs.pnpm_10;
          stylusExtensionId = "{7a7a4a92-a2a0-41d1-9fd7-1e92480d612d}";
          src = (import ./npins).stylus-declarative;
          pnpmDeps = pkgs.fetchPnpmDeps {
            inherit src pnpm;
            pname = "stylus-pnpm-deps";
            hash = "sha256-lrlPd5n5GoBNrUhnyAJK5XskNWLE2NZJr8PHWmOsd58=";
            fetcherVersion = 3; # https://nixos.org/manual/nixpkgs/stable/#javascript-pnpm-fetcherVersion
          };
        in
        pkgs.stdenv.mkDerivation {
          inherit src pnpmDeps;
          name = "stylus-declarative";
          nativeBuildInputs = [
            nodejs
            pnpm
            pkgs.pnpmConfigHook
            pkgs.zip
          ];
          buildPhase = ''
            pnpm run build-firefox
            cd dist-firefox/
            zip -r ../stylus.xpi .
            cd ..
          '';
          installPhase = ''
            dst="$out/share/mozilla/extensions/{ec8030f7-c20a-464f-9b0e-13a3a9e97384}"
            mkdir -p $dst
            cp stylus.xpi $dst/${stylusExtensionId}.xpi
          '';
        };
    };
}
