{
  stdenv,
  fetchPnpmDeps,
  node-gyp,
  nodejs_latest,
  pkg-config,
  pnpmConfigHook,
  pnpm_11,
  python3,
  vips,
  zip,
  ...
}:
let
  nodejs = nodejs_latest;
  pnpm = pnpm_11;
  pnpmDeps = fetchPnpmDeps {
    inherit src pnpm;
    pname = "violentmonkey-pnpm-deps";
    fetcherVersion = 4; # https://nixos.org/manual/nixpkgs/stable/#javascript-pnpm-fetcherVersion
    hash = "sha256-/BsfmGg8oGFUDd99PpwSviGUgNVP0yrKJQ/ndpRzUyk=";
  };
  src = (import ./npins).violentmonkey-declarative;
  violentmonkeyExtensionId = "{aecec67f-0d10-4fa7-b7c7-609a2db280cf}";
in
stdenv.mkDerivation {
  inherit src pnpmDeps;
  nativeBuildInputs = [
    nodejs
    node-gyp
    pnpm
    pnpmConfigHook
    zip
    vips
    pkg-config
    python3
  ];
  env = {
    SHARP_FORCE_GLOBAL_LIBVIPS = 1;
    npm_config_nodedir = nodejs;
  };
  buildPhase = ''
    pnpm run build
    pushd dist/
    zip -r ../violentmonkey.xpi .
    popd
  '';
  installPhase = ''
    dst="$out/share/mozilla/extensions/{ec8030f7-c20a-464f-9b0e-13a3a9e97384}"
    mkdir -p $dst
    cp violentmonkey.xpi $dst/${violentmonkeyExtensionId}.xpi
  '';
  name = "violentmonkey-declarative";
  passthru.extensionId = violentmonkeyExtensionId;
}
