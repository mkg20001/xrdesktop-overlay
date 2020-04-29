{ config, pkgs, lib, ... }:

with lib;
{
  nixpkgs.overlays = [
    (import ./pkgs/overlay.nix (import ./pkgs/hashes.nix))
  ];

  imports = [
    ./modules/xrdesktop.nix
  ];

  services.xrdesktop.enable = true;
}
