{
  perSystem =
    {
      pkgs,
      ...
    }:
    {
      packages.sponsorblock-declarative =
        let
          lib = pkgs.lib;
          nodejs = pkgs.nodejs_25;
          extensionId = "sponsorBlocker@ajay.app";
          src = (import ./npins).sponsorblock-declarative;
          package = builtins.fromJSON (builtins.readFile "${src}/package.json");
          packageLock =
            let
              raw = builtins.fromJSON (builtins.readFile "${src}/package-lock.json");
              patchResolved = modulePath: module:
                if module ? resolved || !(module ? version) || !(lib.hasInfix "node_modules/" modulePath) then
                  module
                else
                  let
                    packagePath = lib.last (lib.splitString "/node_modules/" (lib.removePrefix "node_modules/" modulePath));
                    nameParts = lib.splitString "/" packagePath;
                    packageName =
                      if lib.hasPrefix "@" (builtins.elemAt nameParts 0) then
                        "${builtins.elemAt nameParts 0}/${builtins.elemAt nameParts 1}"
                      else
                        builtins.elemAt nameParts 0;
                    tarballName =
                      if lib.hasPrefix "@" (builtins.elemAt nameParts 0) then
                        builtins.elemAt nameParts 1
                      else
                        builtins.elemAt nameParts 0;
                  in
                  module // {
                    resolved = "https://registry.npmjs.org/${packageName}/-/${tarballName}-${module.version}.tgz";
                  };
            in
            raw // {
              packages = lib.mapAttrs patchResolved raw.packages;
            };
          npmDeps = pkgs.importNpmLock.buildNodeModules {
            inherit nodejs package packageLock;
            npmRoot = src;
            derivationArgs.env.CHROMEDRIVER_SKIP_DOWNLOAD = "true";
          };
        in
        pkgs.stdenv.mkDerivation {
          inherit src;
          name = "sponsorblock-declarative";
          nativeBuildInputs = [
            nodejs
            pkgs.zip
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
          passthru.extensionId = extensionId;
        };
    };
}
