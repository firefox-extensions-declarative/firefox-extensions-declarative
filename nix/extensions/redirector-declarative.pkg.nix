{
  stdenv,
  python3,
  ...
}:
let
  extensionId = "redirector@einaregilsson.com";
  src = (import ./npins).redirector-declarative;
in
stdenv.mkDerivation {
  inherit src;
  nativeBuildInputs = [ python3 ];
  buildPhase = ''
    # ZIP format cannot store timestamps before 1980.
    find . -exec touch -h -d @315532800 {} +
    python build.py
  '';
  installPhase = ''
    dst="$out/share/mozilla/extensions/{ec8030f7-c20a-464f-9b0e-13a3a9e97384}"
    mkdir -p $dst
    cp build/redirector-firefox.xpi $dst/${extensionId}.xpi
  '';
  name = "redirector-declarative";
  passthru.extensionId = extensionId;
}
