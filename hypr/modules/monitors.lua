-- This file is used to configure your monitor sitting for
-- hyprland

------------------
---- MONITORS ----
------------------

-- See https://wiki.hypr.land/Configuring/Basics/Monitors/
-- hl.monitor({ output = "", mode = "preferred", position = "auto", scale = "auto" })

hl.monitor({
    output   = "eDP-2",
    mode     = "2560x1600@240",
    position = "auto",
    scale    = 1.33,
})

hl.monitor({
    output   = "HDMI-A-1",
    mode     = "1920x1080@240",
    position = "0x0",
    scale    = 1,
})

-- hl.monitor({ output = "HDMI-A-1", mode = "preferred", position = "auto", scale = "auto" })
