{
  perSystem =
    {
      pkgs,
      ...
    }:
    {
      packages.userchrome-toggle-extended-2-declarative =
        let
          userChromeToggleExtensionId = "userchrome-toggle-extended@n2ezr.ru";
          src = (import ./npins).userchrome-toggle-extended-2-declarative;
        in
        pkgs.stdenv.mkDerivation {
          inherit src;
          name = "userchrome-toggle-extended-2-declarative";
          nativeBuildInputs = [
            pkgs.zip
          ];
          buildPhase = ''
            zip -r ../userchrome-toggle-extended-2-declarative.xpi .
          '';
          installPhase = ''
            dst="$out/share/mozilla/extensions/{ec8030f7-c20a-464f-9b0e-13a3a9e97384}"
            mkdir -p $dst
            cp ../userchrome-toggle-extended-2-declarative.xpi $dst/${userChromeToggleExtensionId}.xpi
          '';
        };
    };
}
