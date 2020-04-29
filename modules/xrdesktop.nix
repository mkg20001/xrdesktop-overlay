{ config, pkgs, lib, ... }:

with lib;

let
  desktopManager = config.services.xserver.desktopManager;
in
{
  options.services.xrdesktop.enable = mkEnableOption "xrdesktop";

  config = mkIf config.services.xrdesktop.enable (
    /* (optionalAttrs desktopManager.plasma5.enable {
      environment.systemPackages = with pkgs; [ plasma5.kwin-effect-xrdesktop plasma5.kdeplasma-applets-xrdesktop ];
      })
    // */
    /* (optionalAttrs desktopManager.gnome3.enable {
      services.xserver.desktopManager.gnome3.sessionPath = with pkgs; [ gnomeExtensions.xrdesktop ];
      })
    // */
    {
      # Ensure SteamVR is working correctly:
      hardware.steam-hardware.enable = true;
      environment.systemPackages = with pkgs; [ steam ];
    });
}
