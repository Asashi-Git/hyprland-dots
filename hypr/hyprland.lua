-- #######################################################################################
-- ASASHI HYPRLAND CONFIG.
-- EDIT THIS CONFIG ACCORDING TO THE WIKI INSTRUCTIONS.
-- #######################################################################################

-- This configuration file use a modular concept
-- you can find and modify all of the file bellow (inside ./modules).

-- Make `require("modules.xxx")` resolve relative to this file's folder
-- (normally ~/.config/hypr).
local configDir = debug.getinfo(1, "S").source:match("^@(.*/)") or (os.getenv("HOME") .. "/.config/hypr/")
package.path = configDir .. "?.lua;" .. package.path

-- Monitors configuration file
require("modules.monitors")
-- Programs & bin configuration file (returns terminal / fileManager / menu)
require("modules.execs")
-- Autostart configuration file
require("modules.autostart")
-- Env configuration file
require("modules.env")
-- Permission configuration file
require("modules.permissions")
-- General configuration file
require("modules.general")
-- Colors configuration file
require("modules.colors")
-- Decoration configuration file
require("modules.decoration")
-- Animations configuration file
require("modules.animations")
-- Input configuration file
require("modules.input")
-- Keybindings configuration file
require("modules.keybindings")
-- Window-Rules configuration file
require("modules.windowrules")
