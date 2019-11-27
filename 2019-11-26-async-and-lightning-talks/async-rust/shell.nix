{ pkgs ? import <nixpkgs> { } }:
with pkgs;
stdenv.mkDerivation {
  name = "async-rust";
  buildInputs = [ nodejs ];
}
