# Power management: power profiles, lid behaviour, low-battery hibernate.
# Idle locking is in lockscreen.nix.
{
  services = {
    # Performance/balanced/power-saver profiles, shown and switched in waybar
    power-profiles-daemon.enable = true;
    thermald.enable = true;

    logind.settings.Login = {
      HandleLidSwitch = "suspend-then-hibernate";
      HandleLidSwitchExternalPower = "lock";
      HandleLidSwitchDocked = "ignore";
    };

    upower = {
      enable = true;
      usePercentageForPolicy = true;
      percentageLow = 20;
      percentageCritical = 10;
      percentageAction = 5;
      criticalPowerAction = "Hibernate";
    };
  };

  # suspend-then-hibernate: hibernate after two hours of suspend
  systemd.sleep.settings.Sleep.HibernateDelaySec = "2h";
}
