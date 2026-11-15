-- This file is used to configure your main exec bin
-- used inside the config file

---------------------
---- MY PROGRAMS ----
---------------------

-- Set programs that you use.
-- Other modules get them with: local execs = require("modules.execs")
return {
    terminal    = "kitty",
    fileManager = "kitty yazi", -- nemo
    menu        = "rofi -show run",
}
