-- Converted from classic keybinds.conf to the new Lua config format.
-- See https://wiki.hypr.land/Configuring/Basics/Binds/
-- and https://wiki.hypr.land/Configuring/Basics/Dispatchers/

local mainMod = "SUPER" -- Sets "Windows" key as main modifier

-- NOTE: `terminal`, `fileManager`, `menu` are local variables defined in
-- hyprland.lua (not exported by default). If this file is require()'d
-- separately, either re-declare them here or pass them in explicitly, e.g.
-- require("configs.keybinds")(terminal, fileManager, menu)
local terminal    = "kitty"
local fileManager = "thunar"
local menu        = "rofi -show drun"

-- Example binds, see https://wiki.hypr.land/Configuring/Basics/Binds/ for more
hl.bind(mainMod .. " + Return", hl.dsp.exec_cmd(terminal))

-- NOTE: exec_cmd does support window rules, but the exact Lua argument shape
-- for "[float; size 800 550]" wasn't confirmed in the docs at time of writing.
-- Verify this against current docs — this is a best-effort guess.
hl.bind(mainMod .. " + SHIFT + Return", hl.dsp.exec_cmd(terminal, { rules = { "float", "size 800 550" } }))

hl.bind(mainMod .. " + Q", hl.dsp.window.close())

-- NOTE: recommended to use hl.dsp.exit() directly in Lua rather than
-- shelling out to `hyprctl dispatch exit 0`.
hl.bind("CTRL + ALT + Delete", hl.dsp.exit())

hl.bind(mainMod .. " + E", hl.dsp.exec_cmd(fileManager))
hl.bind(mainMod .. " + space", hl.dsp.window.float({ action = "toggle" }))
hl.bind(mainMod .. " + D", hl.dsp.exec_cmd(menu))
hl.bind(mainMod .. " + P", hl.dsp.window.pseudo()) -- dwindle
hl.bind(mainMod .. " + R", hl.dsp.exec_cmd("~/.config/hypr/scripts/wbrestart.sh"))
hl.bind(mainMod .. " + B", hl.dsp.exec_cmd('xdg-open "https://"')) -- default browser
hl.bind(mainMod .. " + L", hl.dsp.exec_cmd("hyprlock"))
hl.bind(mainMod .. " + SHIFT + F", hl.dsp.window.fullscreen({ action = "toggle" }))
hl.bind(mainMod .. " + SHIFT + S", hl.dsp.exec_cmd("~/.config/hypr/scripts/screenshot.sh"))
hl.bind(mainMod .. " + W", hl.dsp.exec_cmd("~/.config/hypr/scripts/wppicker.sh"))
hl.bind(mainMod .. " + CTRL + Q", hl.dsp.exec_cmd("~/.config/hypr/scripts/KillActiveProcess.sh")) -- Kill active process
-- NOTE: hyprpicker is not installed, so this bind is disabled. Install it
-- (`pacman -S hyprpicker`) and re-enable to use the color picker.
-- hl.bind(mainMod .. " + C", hl.dsp.exec_cmd("hyprpicker -a"))
hl.bind(mainMod .. " + H", hl.dsp.exec_cmd("pkill -SIGUSR1 waybar")) -- Hide Waybar
hl.bind(mainMod .. " + SHIFT + E", hl.dsp.exec_cmd("kitty yazi")) -- Yazi File Manager

-- special 0 (main scratchpad)
hl.bind("ALT + Tab", hl.dsp.workspace.toggle_special("0"))

-- numbered specials
hl.bind("ALT + 1", hl.dsp.workspace.toggle_special("1"))
hl.bind("ALT + 2", hl.dsp.workspace.toggle_special("2"))
hl.bind("ALT + 3", hl.dsp.workspace.toggle_special("3"))
hl.bind("ALT + 4", hl.dsp.workspace.toggle_special("4"))

-- CHANGE WALLPAPER
hl.bind(mainMod .. " + SHIFT + W", hl.dsp.exec_cmd("~/.scripts/wall_change.sh 1"))
hl.bind(mainMod .. " + SHIFT + Q", hl.dsp.exec_cmd("~/.scripts/wall_change.sh 0"))

-- Move focus with mainMod + arrow keys
hl.bind(mainMod .. " + left",  hl.dsp.focus({ direction = "l" }))
hl.bind(mainMod .. " + right", hl.dsp.focus({ direction = "r" }))
hl.bind(mainMod .. " + up",    hl.dsp.focus({ direction = "u" }))
hl.bind(mainMod .. " + down",  hl.dsp.focus({ direction = "d" }))

-- Move windows (swap position in direction)
hl.bind(mainMod .. " + CTRL + left",  hl.dsp.window.move({ direction = "l" }))
hl.bind(mainMod .. " + CTRL + right", hl.dsp.window.move({ direction = "r" }))
hl.bind(mainMod .. " + CTRL + up",    hl.dsp.window.move({ direction = "u" }))
hl.bind(mainMod .. " + CTRL + down",  hl.dsp.window.move({ direction = "d" }))

-- Resize windows (repeating, since these were `binde =` in the classic config)
hl.bind(mainMod .. " + SHIFT + left",  hl.dsp.window.resize({ x = -50, y = 0, relative = true }), { repeating = true })
hl.bind(mainMod .. " + SHIFT + right", hl.dsp.window.resize({ x = 50, y = 0, relative = true }), { repeating = true })
hl.bind(mainMod .. " + SHIFT + up",    hl.dsp.window.resize({ x = 0, y = -50, relative = true }), { repeating = true })
hl.bind(mainMod .. " + SHIFT + down",  hl.dsp.window.resize({ x = 0, y = 50, relative = true }), { repeating = true })

-- Switch workspaces with mainMod + [0-9]
-- Move active window to a workspace with mainMod + SHIFT + [0-9]
for i = 1, 10 do
    local key = i % 10 -- 10 maps to key 0
    hl.bind(mainMod .. " + " .. key, hl.dsp.focus({ workspace = i }))
    hl.bind(mainMod .. " + SHIFT + " .. key, hl.dsp.window.move({ workspace = i }))
end

-- Move active window to special workspaces (one-way)
hl.bind(mainMod .. " + ALT + Tab", hl.dsp.window.move({ workspace = "special:0" }))
hl.bind(mainMod .. " + ALT + 1", hl.dsp.window.move({ workspace = "special:1" }))
hl.bind(mainMod .. " + ALT + 2", hl.dsp.window.move({ workspace = "special:2" }))
hl.bind(mainMod .. " + ALT + 3", hl.dsp.window.move({ workspace = "special:3" }))
hl.bind(mainMod .. " + ALT + 4", hl.dsp.window.move({ workspace = "special:4" }))

-- Example special workspace (scratchpad)
-- hl.bind(mainMod .. " + S", hl.dsp.workspace.toggle_special("magic"))
-- hl.bind(mainMod .. " + SHIFT + S", hl.dsp.window.move({ workspace = "special:magic" }))

-- Scroll through existing workspaces with mainMod + scroll
hl.bind(mainMod .. " + mouse_down", hl.dsp.focus({ workspace = "e+1" }))
hl.bind(mainMod .. " + mouse_up",   hl.dsp.focus({ workspace = "e-1" }))

-- Move/resize windows with mainMod + LMB/RMB and dragging
hl.bind("SUPER + mouse:272", hl.dsp.window.drag(),   { mouse = true })
hl.bind("SUPER + mouse:273", hl.dsp.window.resize(), { mouse = true })

hl.bind("SUPER + G", hl.dsp.exec_cmd("nwg-look"))

-- Laptop multimedia keys for volume and LCD brightness
hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+"), { locked = true, repeating = true })
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"), { locked = true, repeating = true })
hl.bind("XF86AudioMute",        hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"), { locked = true, repeating = true })
hl.bind("XF86AudioMicMute",     hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"), { locked = true, repeating = true })

hl.bind("XF86MonBrightnessUp",   hl.dsp.exec_cmd("~/.config/hypr/scripts/brightness.sh --inc"), { locked = true, repeating = true })
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("~/.config/hypr/scripts/brightness.sh --dec"), { locked = true, repeating = true })

-- Requires playerctl
hl.bind("XF86AudioNext",  hl.dsp.exec_cmd("playerctl next"),     { locked = true })
hl.bind("XF86AudioPause", hl.dsp.exec_cmd("playerctl pause"),    { locked = true })
hl.bind("XF86AudioPlay",  hl.dsp.exec_cmd("playerctl play"),     { locked = true })
hl.bind("XF86AudioPrev",  hl.dsp.exec_cmd("playerctl previous"), { locked = true })
