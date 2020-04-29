{ config, pkgs, lib, ... }:

with lib;
{
  nixpkgs.overlays = [
    (import ./overlay.nix)
  ];

  services.xrdesktop.enable = true;
}
