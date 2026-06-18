{
  system ? builtins.currentSystem,
  overrides ? [ ],
}:
let
  polyfillSrc = builtins.fetchTarball {
    url = "https://github.com/bitbloxhub/flake-ultra-polyfill/archive/0730ed1f80b00cdac4cd3c88416845bf470681c0.tar.gz";
    sha256 = "sha256-GTewO3D2TC14lXqLKvrqiAS401DaXQiKMqbNfPZCc0k=";
  };
  polyfill = import polyfillSrc;
  fetched = polyfill.fetchFlakeInputs {
    root = ./.;
    lockFile = ./flake.lock;
    inherit overrides;
  };
  flake = polyfill.callFlake fetched;
in
flake.packages.${system}
