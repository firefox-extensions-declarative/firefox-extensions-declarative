{
  pkgs ? import <nixpkgs> { },
}:
{
  darkreader-declarative = pkgs.callPackage ./nix/extensions/darkreader-declarative.pkg.nix { };
  dearrow-declarative = pkgs.callPackage ./nix/extensions/dearrow-declarative.pkg.nix { };
  redirector-declarative = pkgs.callPackage ./nix/extensions/redirector-declarative.pkg.nix { };
  sponsorblock-declarative = pkgs.callPackage ./nix/extensions/sponsorblock-declarative.pkg.nix { };
  stylus-declarative = pkgs.callPackage ./nix/extensions/stylus-declarative.pkg.nix { };
  surfingkeys-declarative = pkgs.callPackage ./nix/extensions/surfingkeys-declarative.pkg.nix { };
  userchrome-toggle-extended-2-declarative =
    pkgs.callPackage ./nix/extensions/userchrome-toggle-extended-2-declarative.pkg.nix
      { };
  violentmonkey-declarative = pkgs.callPackage ./nix/extensions/violentmonkey-declarative.pkg.nix { };
  youtube-shorts-block-declarative =
    pkgs.callPackage ./nix/extensions/youtube-shorts-block-declarative.pkg.nix
      { };
}
