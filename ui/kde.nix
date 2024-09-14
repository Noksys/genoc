{ config, lib, pkgs, modulesPath, ... }:

let
  vars = import ../../custom_vars.nix;
in
{
  # Enable nm-applet
  #programs.nm-applet.enable = true;

  # Enable Picom for X11 compositing
  #services.picom.enable = true;

  # X11 configuration
  services = {
    xserver = {
      enable = false;

      # Display Manager configuration
      displayManager = {
        lightdm.enable = lib.mkForce false;
        gdm.enable = lib.mkForce false;
      };

      # Desktop Manager configuration
      desktopManager = {
        gnome.enable = lib.mkForce false;
        lxqt.enable = lib.mkForce false;
      };
    };

    # Display Manager without xserver prefix
    displayManager.sddm.enable = lib.mkForce true;
    displayManager.sddm.wayland.enable = lib.mkForce true;

    # Desktop Manager for Plasma (without xserver prefix)
    desktopManager.plasma6.enable = lib.mkForce true;

    # GNOME Keyring
    # gnome.gnome-keyring.enable = true;

    # X11 Screen Lock
    # services.xserver.xautolock.enable = true;
  };

  users.users.${vars.mainUser} = lib.mkMerge [{
    packages = with pkgs; [
      kdePackages.kate
      libsForQt5.kde-cli-tools
      libsForQt5.kservice
      libsForQt5.kdbusaddons
    ];
  }];
}
