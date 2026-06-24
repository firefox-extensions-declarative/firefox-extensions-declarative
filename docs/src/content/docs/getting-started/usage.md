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

You can also get the extension ID by getting `.extensionId` on the extension package.

### Nix (home-manager with alternative input pinners)

Add the equivalent of `github:firefox-extensions-declarative/firefox-extensions-declarative` to your pinner, then import the repo's `default.nix` package set like this:
```nix
let
  firefox-extensions-declarative = import sources.firefox-extensions-declarative {
    inherit pkgs;
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

The package set is built with manual `pkgs.callPackage` entries from `default.nix`.

### Build from source

Clone the extension you want to install and follow the build instructions in its reference.

To install an XPI, go to `about:addons`, click the button to the side of "Manage Your Extensions", and click "Install from file".
