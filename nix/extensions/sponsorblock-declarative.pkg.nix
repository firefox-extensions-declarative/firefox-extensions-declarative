{
  lib,
  stdenv,
  importNpmLock,
  nodejs_latest,
  zip,
  ...
}:
let
  extensionId = "sponsorBlocker@ajay.app";
  nodejs = nodejs_latest;
  npmDeps = importNpmLock.buildNodeModules {
    inherit nodejs package packageLock;
    derivationArgs.env.CHROMEDRIVER_SKIP_DOWNLOAD = "true";
    npmRoot = src;
  };
  package = builtins.fromJSON (builtins.readFile "${src}/package.json");
  packageLock =
    let
      patchResolved =
        modulePath: module:
        if module ? resolved || !(module ? version) || !(lib.hasInfix "node_modules/" modulePath) then
          module
        else
          let
            nameParts = lib.splitString "/" packagePath;
            packageName =
              if lib.hasPrefix "@" (builtins.elemAt nameParts 0) then
                "${builtins.elemAt nameParts 0}/${builtins.elemAt nameParts 1}"
              else
                builtins.elemAt nameParts 0;
            packagePath = lib.last (
              lib.splitString "/node_modules/" (lib.removePrefix "node_modules/" modulePath)
            );
            tarballName =
              if lib.hasPrefix "@" (builtins.elemAt nameParts 0) then
                builtins.elemAt nameParts 1
              else
                builtins.elemAt nameParts 0;
          in
          module
          // {
            resolved = "https://registry.npmjs.org/${packageName}/-/${tarballName}-${module.version}.tgz";
          };
      raw = builtins.fromJSON (builtins.readFile "${src}/package-lock.json");
    in
    raw
    // {
      packages = lib.mapAttrs patchResolved raw.packages;
    };
  src = (import ./npins).sponsorblock-declarative;
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
    zip -r ../sponsorblock.xpi .
    popd
  '';
  installPhase = ''
    dst="$out/share/mozilla/extensions/{ec8030f7-c20a-464f-9b0e-13a3a9e97384}"
    mkdir -p $dst
    cp sponsorblock.xpi $dst/${extensionId}.xpi
  '';
  name = "sponsorblock-declarative";
  passthru.extensionId = extensionId;
}
