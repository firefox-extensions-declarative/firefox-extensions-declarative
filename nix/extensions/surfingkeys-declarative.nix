{
  perSystem =
    {
      pkgs,
      ...
    }:
    {
      packages.surfingkeys-declarative =
        let
          nodejs = pkgs.nodejs_25;
          # Not official, but its in the fork
          surfingkeysExtensionId = "surfingkeys@brookhong.github.io";
          src = (import ./npins).surfingkeys-declarative;
          npmDeps = pkgs.importNpmLock.buildNodeModules {
            inherit nodejs;
            npmRoot = src;
            package = builtins.fromJSON (builtins.readFile "${src}/package.json");
            derivationArgs.nativeBuildInputs = [
              pkgs.node-gyp
              pkgs.pkg-config
              pkgs.pixman
              pkgs.cairo
              pkgs.pango
            ];
            derivationArgs.PUPPETEER_SKIP_DOWNLOAD = "1";
          };
        in
        pkgs.stdenv.mkDerivation {
          inherit src;
          name = "surfingkeys-declarative";
          nativeBuildInputs = [
            nodejs
            pkgs.webpack-cli
          ];
          buildPhase = ''
            mkdir -p node_modules
            cp -r ${npmDeps}/node_modules/* node_modules/
            export PATH=./node_modules/.bin/:$PATH
            ls -la ./node_modules/
            browser=firefox npm run build:prod
          '';
          installPhase = ''
            dst="$out/share/mozilla/extensions/{ec8030f7-c20a-464f-9b0e-13a3a9e97384}"
            mkdir -p $dst
            cp dist/production/firefox/sk.zip $dst/${surfingkeysExtensionId}.xpi
          '';
        };
    };
}
