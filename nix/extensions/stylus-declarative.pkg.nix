{
  stdenv,
  nodejs_latest,
  pnpm_11,
  fetchPnpmDeps,
  pnpmConfigHook,
  zip,
  ...
}:
let
  nodejs = nodejs_latest;
  pnpm = pnpm_11;
  stylusExtensionId = "{7a7a4a92-a2a0-41d1-9fd7-1e92480d612d}";
  src = (import ./npins).stylus-declarative;
  pnpmDeps = fetchPnpmDeps {
    inherit src pnpm;
    pname = "stylus-pnpm-deps";
    hash = "sha256-oSWx87VQ2zX0eOeoncQZ4SzWvMj2543n44/shNcYPBk=";
    fetcherVersion = 4; # https://nixos.org/manual/nixpkgs/stable/#javascript-pnpm-fetcherVersion
  };
in
stdenv.mkDerivation {
  inherit src pnpmDeps;
  name = "stylus-declarative";
  nativeBuildInputs = [
    nodejs
    pnpm
    pnpmConfigHook
    zip
  ];
  buildPhase = ''
    pnpm run build-firefox
    cd dist-firefox/
    zip -r ../stylus.xpi .
    cd ..
  '';
  installPhase = ''
    dst="$out/share/mozilla/extensions/{ec8030f7-c20a-464f-9b0e-13a3a9e97384}"
    mkdir -p $dst
    cp stylus.xpi $dst/${stylusExtensionId}.xpi
  '';
  passthru.extensionId = stylusExtensionId;
}
