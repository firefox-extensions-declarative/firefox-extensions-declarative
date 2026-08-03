{
  stdenv,
  importNpmLock,
  nodejs_latest,
  zip,
  ...
}:
let
  extensionId = "deArrow@ajay.app";
  nodejs = nodejs_latest;
  npmDeps = importNpmLock.buildNodeModules {
    inherit nodejs;
    derivationArgs.env.CHROMEDRIVER_SKIP_DOWNLOAD = "true";
    npmRoot = src;
    package = builtins.fromJSON (builtins.readFile "${src}/package.json");
  };
  src = (import ./npins).dearrow-declarative;
in
stdenv.mkDerivation {
  inherit src;
  nativeBuildInputs = [
    nodejs
    zip
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
  name = "dearrow-declarative";
  passthru.extensionId = extensionId;
}
