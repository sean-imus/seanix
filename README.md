# seanix

NixOS and home-manager configuration for one laptop (`notebook`) and one user (`sean`).

## Layout

Every module is one feature and holds everything that feature needs: packages,
settings, colours, keybindings and window rules. Each file starts with a comment
saying what it does.

- `flake.nix` — inputs and the `notebook` system
- `modules/notebook.nix` — the host: hardware, boot, and the list of system modules
- `modules/sean.nix` — the user account and the list of home modules
- `modules/nixos/` — features that need system-level settings; their per-user
  parts sit in the same file under `home-manager.sharedModules`
- `modules/home/` — features that only need home-manager
- `modules/lib/` — plain functions, imported explicitly where used
- `secrets/` — sops-encrypted secrets
- `assets/` — wallpaper and install scripts

### System modules (`modules/nixos/`)

| Module | What it does |
|---|---|
| `audio.nix` | PipeWire, media keys, wiremix mixer (Mod+Ctrl+A) |
| `bluetooth.nix` | Bluetooth with bluetui (Mod+Ctrl+B) |
| `claude-code.nix` | Claude Code with MCP, LSP, status line and a Nix lint hook |
| `claude-sudo.nix` | Time-limited passwordless sudo for Claude after a polkit prompt |
| `clipboard.nix` | Clipboard history with cliphist (Mod+Ctrl+Y) |
| `disk.nix` | Disk layout: EFI + LUKS-encrypted ext4, swap file |
| `fonts.nix` | System fonts |
| `hardware-dev.nix` | USB-serial and Android device access, Arduino/ESP tools |
| `locale.nix` | Time zone, language, formats, keyboard layout |
| `lockscreen.nix` | swaylock and swayidle (Super+Alt+L) |
| `niri.nix` | niri system side and boot-to-desktop |
| `nix.nix` | Nix settings and nh |
| `power.nix` | Power profiles, lid behaviour, battery thresholds |
| `printing.nix` | Printing and scanning |
| `rdp-work.nix` | Remote desktop to the work laptop over ethernet |
| `secrets.nix` | sops-nix key and the `sops` wrapper |
| `virtualisation.nix` | libvirt/QEMU and virt-manager |
| `wifi.nix` | Known WiFi networks (from `secrets/wifi.env`) |

### Home modules (`modules/home/`)

| Module | What it does |
|---|---|
| `appearance.nix` | GTK theme, icons, cursor |
| `browser.nix` | Chromium with four separate profiles |
| `desktop-shell.nix` | waybar, notifications, on-screen display, polkit agent |
| `editor.nix` | Neovim (nixvim) |
| `extra-apps.nix` | LibreOffice and mpv |
| `git.nix` | Git, GitHub CLI, lazygit |
| `launcher.nix` | fuzzel (Mod+Space) |
| `niri/` | niri keybindings, monitors and behaviour |
| `shell.nix` | fish and command-line tools |
| `terminal.nix` | foot (Mod+T) |

## Installation

```bash
sudo mount --mkdir /dev/mapper/VentoyPart /usb && sh /usb/install.sh
```
