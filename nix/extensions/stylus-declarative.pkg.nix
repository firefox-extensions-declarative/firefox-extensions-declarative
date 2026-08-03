{
  stdenv,
  fetchPnpmDeps,
  nodejs_latest,
  pnpmConfigHook,
  pnpm_11,
  zip,
  ...
}:
let
  nodejs = nodejs_latest;
  pnpm = pnpm_11;
  pnpmDeps = fetchPnpmDeps {
    inherit src pnpm;
    pname = "stylus-pnpm-deps";
    fetcherVersion = 4; # https://nixos.org/manual/nixpkgs/stable/#javascript-pnpm-fetcherVersion
    hash = "sha256-fSsfDm+mnL/H7opoZSAt7X+tRZA19ooCfapJd8yKlVs=";
  };
  src = (import ./npins).stylus-declarative;
  stylusExtensionId = "{7a7a4a92-a2a0-41d1-9fd7-1e92480d612d}";
in
stdenv.mkDerivation {
  inherit src pnpmDeps;
  nativeBuildInputs = [
    nodejs
    pnpm
    pnpmConfigHook
    zip
  ];
  buildPhase = ''
    pnpm run build-firefox
    cd dist-firefox-mv2/
    zip -r ../stylus.xpi .
    cd ..
  '';
  installPhase = ''
    dst="$out/share/mozilla/extensions/{ec8030f7-c20a-464f-9b0e-13a3a9e97384}"
    mkdir -p $dst
    cp stylus.xpi $dst/${stylusExtensionId}.xpi
  '';
  name = "stylus-declarative";
  passthru.extensionId = stylusExtensionId;
}
