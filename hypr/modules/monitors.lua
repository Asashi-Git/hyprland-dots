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
    position = "0x0",
    scale    = 1.33,
})

hl.monitor({
    output   = "HDMI-A-1",
    -- HDMI only advertises up to 120Hz on this monitor (240Hz needs DisplayPort)
    mode     = "1920x1080@119.98",
    position = "1920x0", -- right of the laptop (2560 / 1.33 scale = 1920 logical px wide)
    scale    = 1,
})

-- hl.monitor({ output = "HDMI-A-1", mode = "preferred", position = "auto", scale = "auto" })
