{
  stdenv,
  nodejs_latest,
  importNpmLock,
  ...
}:
let
  nodejs = nodejs_latest;
  src = (import ./npins).darkreader-declarative;
  npmDeps = importNpmLock.buildNodeModules {
    inherit nodejs;
    npmRoot = src;
    package = builtins.fromJSON (builtins.readFile "${src}/package.json");
  };
in
stdenv.mkDerivation {
  inherit src;
  name = "darkreader-declarative";
  nativeBuildInputs = [ nodejs ];
  buildPhase = ''
    mkdir -p node_modules
    cp -r ${npmDeps}/node_modules/* node_modules/
    npm run build:firefox
  '';
  installPhase = ''
    dst="$out/share/mozilla/extensions/{ec8030f7-c20a-464f-9b0e-13a3a9e97384}"
    mkdir -p $dst
    cp build/release/darkreader-firefox.xpi $dst/addon@darkreader.org.xpi
  '';
  passthru.extensionId = "addon@darkreader.org";
}
