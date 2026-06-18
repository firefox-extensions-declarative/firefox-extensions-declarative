---
title: Usage
---

First, before you can use these extensions, you need a browser that is built with `MOZ_REQUIRE_SIGNING=""`.

Here is a non-exhaustive list of these:
- [Librewolf](https://librewolf.net/)
- [Firefox Developer Edition](https://www.firefox.com/en-US/channel/desktop/developer/)
- [Firefox Nightly](https://www.firefox.com/en-US/channel/desktop/#nightly)
- [Zen Browser](https://zen-browser.app/)
- [Glide](https://glide-browser.app/)
- Many other Firefox forks.

Then set `xpinstall.signatures.required` to `false` in either `user.js` or `about:config`.

## Installation
Once you have a browser that supports unsigned extensions, follow the instructions for your platform.

### Nix (with flakes and home-manager)

First, add the `github:firefox-extensions-declarative/firefox-extensions-declarative` flake to your flake inputs.  
Now, you can use the extensions in you home-manager configuration like so:
```nix
# Example with surfingkeys-declarative
{
  programs.firefox.profiles.nix = {
    extensions.packages = [
      inputs.firefox-extensions-declarative.packages.${pkgs.stdenv.hostPlatform.system}.surfingkeys-declarative
    ];
  };
  programs.firefox.policies = {
    "3rdparty".Extensions."surfingkeys@brookhong.github.io" = {
      showAdvanced = true;
      snippets = builtins.readFile ./surfingkeys.js;
    };
  };
}
```

### Nix (home-manager with alternative input pinners)

Add the equivalent of `github:firefox-extensions-declarative/firefox-extensions-declarative` to your pinner, then you can instantiate the package set like this:
```nix
let
  firefox-extensions-declarative = import sources.firefox-extensions-declarative {
    system = pkgs.stdenv.hostPlatform.system;
    overrides = [
      {
        path = [ "nixpkgs" ];
        value = {
          sourceInfo.outPath = sources.nixpkgs;
        };
      }
    ];
  };
in
{
  programs.firefox.profiles.nix = {
    extensions.packages = [
      firefox-extensions-declarative.surfingkeys-declarative
    ];
  };
}
```

Powered by [`flake-ultra-polyfill`](https://github.com/bitbloxhub/flake-ultra-polyfill/).

### Build from source

Clone the extension you want to install and follow the build instructions in its reference.

To install an XPI, go to `about:addons`, click the button to the side of "Manage Your Extensions", and click "Install from file".
