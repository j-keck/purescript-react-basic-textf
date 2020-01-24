let

  # steps to update package set:
  #  - fetch the actual commit: git ls-remote https://github.com/nixos/nixpkgs-channels nixos-19.09
  #  - get the sha256: nix-prefetch-url --unpack https://github.com/NixOS/nixpkgs/archive/<COMMIT>.tar.gz
  pkgs = import (builtins.fetchTarball {
    name = "nixos-19.09-57b7b0";
    url = https://github.com/NixOS/nixpkgs/archive/57b7b019812fbe2cb760dd38d521f1cc16b14877.tar.gz;
    sha256 = "0xsgwyp4dfsfynag2prkagw0mdg7zx7gyljf8yvsc047ppnd85a8";
  }) {};

  # 2019-12-04T18:20:17+09:00
  easy-ps = import (pkgs.fetchFromGitHub {
    owner = "justinwoo";
    repo = "easy-purescript-nix";
    rev = "6cb5825430ab44719139f28b93d50c5810891366";
    sha256 = "1awsywpw92xr4jmkwfj2s89wih74iw4ppaifc97n9li4pyds56h4";
  }) { inherit pkgs; };


  buildInputs =
    (with pkgs; [ dhall nodejs chromium ]) ++
    (with pkgs.nodePackages; [ parcel-bundler bower pulp ]) ++
    (with easy-ps; [ purs spago spago2nix ]);

in pkgs.mkShell {
  inherit buildInputs;

  shellHooks =
    let make-example-screenshot = name: window-size:
          pkgs.writeScript "make-${name}-example-screenshot.sh" ''
            spago build
            parcel build --public-url ./ example/${name}-example.html
            chromium --headless --window-size=${window-size} \
               --screenshot=example/${name}-example.png dist/${name}-example.html
          '';
    in ''
      alias make-usage-example-screenshot="${make-example-screenshot "usage" "300x70"}"
      alias make-full-example-screenshot="${make-example-screenshot "full" "400x400"}"
      alias make-all-screenshots="make-usage-example-screenshot; make-full-example-screenshot"
  '';
}
