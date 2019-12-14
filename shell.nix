{ pkgs ? import <nixpkgs> {} }:
let

  # 2019-12-04T18:20:17+09:00
  easy-ps = import (pkgs.fetchFromGitHub {
    owner = "justinwoo";
    repo = "easy-purescript-nix";
    rev = "6cb5825430ab44719139f28b93d50c5810891366";
    sha256 = "1awsywpw92xr4jmkwfj2s89wih74iw4ppaifc97n9li4pyds56h4";
  }) { inherit pkgs; };


  buildInputs =
    (with pkgs; [ dhall nodejs chromium ]) ++
    (with pkgs.nodePackages; [ parcel-bundler ]) ++
    (with easy-ps; [ purs spago spago2nix ]);

in pkgs.mkShell {
  inherit buildInputs;

  shellHooks = ''
    alias create-example="parcel build --public-url ./ example/index.html"
    alias create-example-screenshot="create-example && chromium --headless --screenshot=example/index.png dist/index.html"
    alias build-example-screenshot="spago build && create-example-screenshot"
  '';
}
