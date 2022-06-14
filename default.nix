let
 pkgs = import <nixpkgs> { };
in
 pkgs.haskellPackages.callPackage ./release.nix { }
