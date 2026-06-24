{
  perSystem =
    {
      pkgs,
      ...
    }:
    {
      packages.dearrow-declarative =
        let
          nodejs = pkgs.nodejs_25;
          extensionId = "deArrow@ajay.app";
          src = (import ./npins).dearrow-declarative;
          npmDeps = pkgs.importNpmLock.buildNodeModules {
            inherit nodejs;
            npmRoot = src;
            package = builtins.fromJSON (builtins.readFile "${src}/package.json");
            derivationArgs.env.CHROMEDRIVER_SKIP_DOWNLOAD = "true";
          };
        in
        pkgs.stdenv.mkDerivation {
          inherit src;
          name = "dearrow-declarative";
          nativeBuildInputs = [
            nodejs
            pkgs.zip
          ];
          buildPhase = ''
            cp -r ${npmDeps}/node_modules .
            chmod -R u+w node_modules
            cp config.json.example config.json
            npm run build:firefox
            pushd dist/
            zip -r ../dearrow.xpi .
            popd
          '';
          installPhase = ''
            dst="$out/share/mozilla/extensions/{ec8030f7-c20a-464f-9b0e-13a3a9e97384}"
            mkdir -p $dst
            cp dearrow.xpi $dst/${extensionId}.xpi
          '';
          passthru.extensionId = extensionId;
        };
    };
}
