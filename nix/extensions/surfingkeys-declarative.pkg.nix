{
  stdenv,
  nodejs_latest,
  importNpmLock,
  pixman,
  cairo,
  pango,
  node-gyp,
  pkg-config,
  webpack-cli,
  ...
}:
let
  nodejs = nodejs_latest;
  # Not official, but its in the fork
  surfingkeysExtensionId = "surfingkeys@brookhong.github.io";
  src = (import ./npins).surfingkeys-declarative;
  npmDeps = importNpmLock.buildNodeModules {
    inherit nodejs;
    npmRoot = src;
    package = builtins.fromJSON (builtins.readFile "${src}/package.json");
    derivationArgs.nativeBuildInputs = [
      node-gyp
      pkg-config
      pixman
      cairo
      pango
    ];
    derivationArgs.env.PUPPETEER_SKIP_DOWNLOAD = "1";
  };
in
stdenv.mkDerivation {
  inherit src;
  name = "surfingkeys-declarative";
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
  passthru.extensionId = surfingkeysExtensionId;
}
