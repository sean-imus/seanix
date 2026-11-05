{ config, pkgs, ... }:
let
  user = "sean";
  rule = "/run/sudoers.d/claude";
  unit = "claude-sudo-expire";
  wrappers = config.security.wrapperDir;

  grant = pkgs.writeShellApplication {
    name = "claude-sudo-grant";
    runtimeInputs = [
      pkgs.coreutils
      pkgs.systemd
      config.security.sudo.package
    ];
    text = ''
      stop() {
        systemctl stop ${unit}.timer ${unit}.service 2>/dev/null || true
      }

      case "''${1:-}" in
        grant)
          duration=''${2:-1h}
          if [[ ! $duration =~ ^([1-9][0-9]*)([mh])$ ]]; then
            echo "invalid duration: $duration (expected e.g. 30m or 1h)" >&2
            exit 1
          fi
          minutes=''${BASH_REMATCH[1]}
          [[ ''${BASH_REMATCH[2]} == h ]] && minutes=$((minutes * 60))
          if ((minutes > 480)); then
            echo "duration too long: max 8h" >&2
            exit 1
          fi

          tmp=$(mktemp)
          trap 'rm -f "$tmp"' EXIT
          echo "${user} ALL=(ALL:ALL) NOPASSWD: ALL" >"$tmp"
          visudo -cqf "$tmp"

          stop
          install -m 0440 -o root -g root "$tmp" ${rule}
          systemd-run --quiet --unit=${unit} --on-active="''${minutes}m" \
            ${pkgs.coreutils}/bin/rm -f ${rule}
          echo "sudo without password enabled for ''${minutes}m"
          ;;
        revoke)
          stop
          rm -f ${rule}
          echo "sudo without password disabled"
          ;;
        *)
          echo "usage: claude-sudo-grant grant [duration] | revoke" >&2
          exit 1
          ;;
      esac
    '';
  };

  claudeSudo = pkgs.writeShellApplication {
    name = "claude-sudo";
    runtimeInputs = [ pkgs.systemd ];
    text = ''
      active() {
        systemctl is-active --quiet ${unit}.timer
      }

      case "''${1:-1h}" in
        off)
          if active; then
            ${wrappers}/sudo -n ${grant}/bin/claude-sudo-grant revoke
          else
            echo "not active"
          fi
          ;;
        status)
          if active; then
            systemctl list-timers ${unit}.timer --no-pager
          else
            echo "not active"
          fi
          ;;
        *)
          ${wrappers}/pkexec ${grant}/bin/claude-sudo-grant grant "''${1:-1h}"
          ;;
      esac
    '';
  };

  policy = pkgs.writeTextDir "share/polkit-1/actions/org.seanix.claude-sudo.policy" ''
    <?xml version="1.0" encoding="UTF-8"?>
    <!DOCTYPE policyconfig PUBLIC "-//freedesktop//DTD PolicyKit Policy Configuration 1.0//EN"
      "http://www.freedesktop.org/standards/PolicyKit/1/policyconfig.dtd">
    <policyconfig>
      <action id="org.seanix.claude-sudo">
        <description>Grant Claude Code temporary passwordless sudo</description>
        <message>Claude Code möchte befristet sudo ohne Passwort nutzen (Standard: 1 Stunde)</message>
        <defaults>
          <allow_any>no</allow_any>
          <allow_inactive>no</allow_inactive>
          <allow_active>auth_admin</allow_active>
        </defaults>
        <annotate key="org.freedesktop.policykit.exec.path">${grant}/bin/claude-sudo-grant</annotate>
      </action>
    </policyconfig>
  '';
in
{
  security = {
    polkit.enablePkexecWrapper = true;
    sudo.extraConfig = "@includedir /run/sudoers.d";
  };

  systemd.tmpfiles.rules = [ "d /run/sudoers.d 0750 root root -" ];

  environment.systemPackages = [
    claudeSudo
    policy
  ];

  home-manager.sharedModules = [
    {
      programs.claude-code = {
        settings.permissions.allow = [
          "Bash(claude-sudo)"
          "Bash(claude-sudo *)"
        ];

        skills.sudo = ''
          ---
          name: sudo
          description: Get temporary root access on this machine. Use whenever a command needs sudo/root (e.g. nixos-rebuild switch, systemctl on system units, journalctl for system services).
          ---

          # Temporary sudo

          Root access is off by default. `claude-sudo` turns on passwordless sudo
          for a limited time after the user confirms a graphical polkit password dialog.

          1. Run `claude-sudo status` to check whether access is already active.
          2. If not active, tell the user in one short line that a password dialog
             is about to appear and why, then run `claude-sudo` (default 1h,
             or e.g. `claude-sudo 30m`, max 8h). It blocks until the user answers.
             If it fails or is cancelled, do not retry; ask the user instead.
          3. Always call sudo as `sudo -n ...` so it fails instead of hanging
             when access has expired.
          4. When the task that needed root is done, run `claude-sudo off`.
        '';
      };
    }
  ];
}
