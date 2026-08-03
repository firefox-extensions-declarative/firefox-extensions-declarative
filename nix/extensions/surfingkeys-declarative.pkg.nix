{
  stdenv,
  cairo,
  importNpmLock,
  node-gyp,
  nodejs_latest,
  pango,
  pixman,
  pkg-config,
  webpack-cli,
  ...
}:
let
  nodejs = nodejs_latest;
  npmDeps = importNpmLock.buildNodeModules {
    inherit nodejs;
    derivationArgs = {
      nativeBuildInputs = [
        node-gyp
        pkg-config
        pixman
        cairo
        pango
      ];
      env.PUPPETEER_SKIP_DOWNLOAD = "1";
    };
    npmRoot = src;
    package = builtins.fromJSON (builtins.readFile "${src}/package.json");
  };
  src = (import ./npins).surfingkeys-declarative;
  # Not official, but its in the fork
  surfingkeysExtensionId = "surfingkeys@brookhong.github.io";
in
stdenv.mkDerivation {
  inherit src;
  nativeBuildInputs = [
    nodejs
    webpack-cli
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
  name = "surfingkeys-declarative";
  passthru.extensionId = surfingkeysExtensionId;
}
