args@{
  stdenv,
  nodejs_25,
  fetchYarnDeps,
  yarn,
  yarnConfigHook,
  zip,
  vips,
  python3,
  ...
}:
let
  nodejs = nodejs_25;
  nodeGyp = args."node-gyp";
  pkgConfig = args."pkg-config";
  violentmonkeyExtensionId = "{aecec67f-0d10-4fa7-b7c7-609a2db280cf}";
  src = (import ./npins).violentmonkey-declarative;
  yarnDeps = fetchYarnDeps {
    inherit src;
    pname = "violentmonkey-yarn-deps";
    hash = "sha256-yZd3jLaSmBzSLaYChZ/vNmalOawqQ3y/Xw57QwVhbQE=";
  };
in
stdenv.mkDerivation {
  inherit src;
  name = "violentmonkey-declarative";
  yarnOfflineCache = yarnDeps;
  env.SHARP_FORCE_GLOBAL_LIBVIPS = 1;
  env.npm_config_nodedir = nodejs;
  nativeBuildInputs = [
    nodejs
    nodeGyp
    yarn
    yarnConfigHook
    zip
    vips
    pkgConfig
    python3
  ];
  buildPhase = ''
    pushd node_modules/sharp
    yarn --offline run install
    popd
    yarn run build
    pushd dist/
    zip -r ../violentmonkey.xpi .
    popd
  '';
  installPhase = ''
    dst="$out/share/mozilla/extensions/{ec8030f7-c20a-464f-9b0e-13a3a9e97384}"
    mkdir -p $dst
    cp violentmonkey.xpi $dst/${violentmonkeyExtensionId}.xpi
  '';
  passthru.extensionId = violentmonkeyExtensionId;
}
