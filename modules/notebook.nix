{ pkgs, ... }:
{
  imports = [
    ./nixos/audio.nix
    ./nixos/bluetooth.nix
    ./nixos/claude-code.nix
    ./nixos/claude-sudo.nix
    ./nixos/clipboard.nix
    ./nixos/disk.nix
    ./nixos/fonts.nix
    ./nixos/hardware-dev.nix
    ./nixos/locale.nix
    ./nixos/lockscreen.nix
    ./nixos/niri.nix
    ./nixos/nix.nix
    ./nixos/power.nix
    ./nixos/printing.nix
    ./nixos/rdp-work.nix
    ./nixos/secrets.nix
    ./nixos/virtualisation.nix
    ./nixos/wifi.nix
    ./sean.nix
  ];

  networking = {
    hostName = "notebook";
    networkmanager.enable = true;
    modemmanager.enable = false;
  };

  hardware = {
    enableRedistributableFirmware = true;
    cpu.intel.updateMicrocode = true;

    graphics.extraPackages = [ pkgs.intel-media-driver ];
  };

  services = {
    fwupd.enable = true;
    speechd.enable = false;
  };

  programs = {
    # Logitech receivers and devices
    solaar.enable = true;
    nano.enable = false;
  };

  environment.defaultPackages = [ ];

  documentation = {
    doc.enable = false;
    info.enable = false;
    nixos.enable = false;
  };

  boot = {
    supportedFilesystems = [ "ntfs" ];

    initrd.availableKernelModules = [
      "nvme"
      "thunderbolt"
      "xhci_pci"
      "usbhid"
    ];

    kernelModules = [ "kvm-intel" ];
    tmp.cleanOnBoot = true;

    loader = {
      systemd-boot = {
        enable = true;
        configurationLimit = 5;
        editor = false;
      };
      efi.canTouchEfiVariables = true;
      timeout = 0;
    };

    # Tuned for compressed swap in RAM: swap eagerly, read one page at a time
    kernel.sysctl = {
      "vm.page-cluster" = 0;
      "vm.swappiness" = 180;
    };
  };

  zramSwap.enable = true;

  system.stateVersion = "26.11";
}
