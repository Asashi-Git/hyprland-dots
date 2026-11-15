-- This file is used to configure your bin & programs
-- that need to be lunched at boot

-------------------
---- AUTOSTART ----
-------------------

-- See https://wiki.hypr.land/Configuring/Basics/Autostart/

hl.on("hyprland.start", function()
    hl.exec_cmd("systemctl --user start hyprpolkitagent")
    hl.exec_cmd("waybar")
    hl.exec_cmd("/usr/bin/awww-daemon")
    hl.exec_cmd("swaync")

    -- Obtional, uncomment only if you have downloaded my waybar dots
    -- and my swaync dots
    hl.exec_cmd("~/.config/swaync/notification-scripts/pw-profile-listener.sh")

    -- Obtional, uncomment only if you have downloaded my swaync dots
    hl.exec_cmd("~/.config/swaync/notification-scripts/music-notify.sh")

    -- Obtional, uncomment only if you use my dots file with hypridle
    -- and hyprlock config together
    hl.exec_cmd("hypridle")
end)
