{ config, pkgs, system, ... }:

{
  home.username = "lampis";
  home.homeDirectory = "/home/lampis";
  home.stateVersion = "25.11";

  targets.genericLinux.enable = true;
  targets.genericLinux.gpu.enable = false;

  home.packages = with pkgs; [
  # For Packages: 
  # #1 not in portage, 
  # #2 too big for portage
    obsidian
    zed-editor
    parallel-launcher
    vesktop
    dolphin-emu
    prismlauncher
    steam
    go
    libreoffice
    flitter
    
    cowsay
    vulkan-tools
  ];

  nixpkgs.config.allowUnfree = true;
  programs.home-manager.enable = true;
  dconf.settings = {
  };

# Ensure Nix apps can find the portals (file picker, screen share)
  xdg.portal = {
    enable = true;
    extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
    config.common.default = "*";
  };
}
