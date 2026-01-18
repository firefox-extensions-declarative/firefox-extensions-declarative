{
  perSystem =
    {
      pkgs,
      ...
    }:
    {
      packages.violentmonkey-declarative =
        let
          nodejs = pkgs.nodejs_25;
          violentmonkeyExtensionId = "{aecec67f-0d10-4fa7-b7c7-609a2db280cf}";
          src = (import ./npins).violentmonkey-declarative;
          yarnDeps = pkgs.fetchYarnDeps {
            inherit src;
            pname = "violentmonkey-yarn-deps";
            hash = "sha256-k8kQgo1bDasECRdxs2/Asgc7itV/sB0hbFdpjTXmqvk=";
          };
        in
        pkgs.stdenv.mkDerivation {
          inherit src;
          name = "violentmonkey-declarative";
          yarnOfflineCache = yarnDeps;
          env.SHARP_FORCE_GLOBAL_LIBVIPS = 1;
          env.npm_config_nodedir = nodejs;
          nativeBuildInputs = [
            nodejs
            pkgs.node-gyp
            pkgs.yarn
            pkgs.yarnConfigHook
            pkgs.zip
            pkgs.vips
            pkgs.pkg-config
            pkgs.python3
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
        };
    };
}
