{ pkgs ? import <nixpkgs> { } }:
pkgs.mkShell {
  packages = [ pkgs.opam ];

  shellHook = ''
    eval $(opam env)
  '';
}
