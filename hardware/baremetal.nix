{ config, lib, pkgs, modulesPath, ... }:

{
  imports = [
    ../../hardware-configuration.nix
    ../sound/pulseaudio.nix
    ./bluetooth.nix
  ];

  # Virtualization
  virtualisation.vmware.guest.enable = false;


  environment.systemPackages = lib.mkMerge [
    (with pkgs; [
      lm_sensors
    ])
  ];
}
