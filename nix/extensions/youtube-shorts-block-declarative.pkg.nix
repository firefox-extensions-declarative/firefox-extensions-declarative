{
  stdenv,
  importNpmLock,
  nodejs_latest,
  ...
}:
let
  extensionId = "{34daeb50-c2d2-4f14-886a-7160b24d66a4}";
  nodejs = nodejs_latest;
  npmDeps = importNpmLock.buildNodeModules {
    inherit nodejs;
    npmRoot = src;
    package = builtins.fromJSON (builtins.readFile "${src}/package.json");
  };
  src = (import ./npins).youtube-shorts-block-declarative;
in
stdenv.mkDerivation {
  inherit src;
  nativeBuildInputs = [ nodejs ];
  buildPhase = ''
    cp -r ${npmDeps}/node_modules .
    chmod -R u+w node_modules
    npm run build
  '';
  installPhase = ''
    dst="$out/share/mozilla/extensions/{ec8030f7-c20a-464f-9b0e-13a3a9e97384}"
    mkdir -p $dst
    cp Youtube-shorts_block_*_fx.zip $dst/${extensionId}.xpi
  '';
  name = "youtube-shorts-block-declarative";
  passthru.extensionId = extensionId;
}
