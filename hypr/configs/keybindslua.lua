-- Converted from classic keybinds.conf to the new Lua config format.
-- See https://wiki.hypr.land/Configuring/Basics/Binds/
-- and https://wiki.hypr.land/Configuring/Basics/Dispatchers/

local mainMod = "SUPER" -- Sets "Windows" key as main modifier
local ipc = "qs -c noctalia-shell ipc call"

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
hl.bind(mainMod .. " + L", hl.dsp.exec_cmd("~/.config/hypr/scripts/hyprlock.sh"))
hl.bind(mainMod .. " + SHIFT + F", hl.dsp.window.fullscreen({ action = "toggle" }))
hl.bind(mainMod .. " + SHIFT + S", hl.dsp.exec_cmd("~/.config/hypr/scripts/screenshot.sh"))
hl.bind(mainMod .. " + W", hl.dsp.exec_cmd("~/.config/hypr/scripts/wppicker.sh"))
hl.bind(mainMod .. " + SHIFT + Q", hl.dsp.exec_cmd("~/.config/hypr/scripts/KillActiveProcess.sh")) -- Kill active process
hl.bind(mainMod .. " + C", hl.dsp.exec_cmd("hyprpicker -a"))
hl.bind(mainMod .. " + CTRL + B", hl.dsp.exec_cmd("~/.config/hypr/scripts/WaybarStyles.sh")) -- Waybar Styles Menu
hl.bind(mainMod .. " + ALT + B", hl.dsp.exec_cmd("~/.config/hypr/scripts/WaybarLayout.sh")) -- Waybar Layout Menu
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
-- NOTE: your original file binds mainMod+SHIFT+W here for wall_change.sh, but
-- mainMod+W is already bound above to wppicker.sh, and mainMod+SHIFT+Q is
-- already bound above to KillActiveProcess.sh — these lines are carried over
-- verbatim, but the duplicate/conflicting keys existed in your source file too.
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

-- SCREENSHOT
-- NOTE: this duplicates the mainMod+SHIFT+S bind set above (screenshot.sh);
-- carried over verbatim from your source file, where the later `bind =` line
-- would take priority.
hl.bind(mainMod .. " + SHIFT + S", hl.dsp.exec_cmd(
    [[mkdir -p ~/Pictures/Screenshots && grim -g "$(slurp)" - | wl-copy && wl-paste > ~/Pictures/Screenshots/Screenshot_$(date +'%Y%m%d_%H%M%S').png]]
))

-- Example special workspace (scratchpad)
-- hl.bind(mainMod .. " + S", hl.dsp.workspace.toggle_special("magic"))
-- hl.bind(mainMod .. " + SHIFT + S", hl.dsp.window.move({ workspace = "special:magic" }))

-- Scroll through existing workspaces with mainMod + scroll
hl.bind(mainMod .. " + mouse_down", hl.dsp.focus({ workspace = "e+1" }))
hl.bind(mainMod .. " + mouse_up",   hl.dsp.focus({ workspace = "e-1" }))

-- Move/resize windows with mainMod + LMB/RMB and dragging
hl.bind("SUPER + mouse:272", hl.dsp.window.drag(),   { mouse = true })
hl.bind("SUPER + mouse:273", hl.dsp.window.resize(), { mouse = true })

hl.bind("SUPER + G", hl.dsp.exec_cmd("nwg-look; ~/.config/hypr/update-gtk-env.sh"))

-- Laptop multimedia keys for volume and LCD brightness (via noctalia ipc)
hl.bind("XF86AudioRaiseVolume",   hl.dsp.exec_cmd(ipc .. " volume increase"),   { locked = true, repeating = true })
hl.bind("XF86AudioLowerVolume",   hl.dsp.exec_cmd(ipc .. " volume decrease"),   { locked = true, repeating = true })
hl.bind("XF86AudioMute",          hl.dsp.exec_cmd(ipc .. " volume muteOutput"), { locked = true, repeating = true })
hl.bind("XF86AudioMicMute",       hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"), { locked = true, repeating = true })
hl.bind("XF86MonBrightnessUp",    hl.dsp.exec_cmd("~/.config/hypr/scripts/brightness.sh --inc"), { locked = true, repeating = true })
hl.bind("XF86MonBrightnessDown",  hl.dsp.exec_cmd("~/.config/hypr/scripts/brightness.sh --dec"), { locked = true, repeating = true })

-- Requires playerctl
hl.bind("XF86AudioNext",  hl.dsp.exec_cmd(ipc .. " media next"),     { locked = true })
hl.bind("XF86AudioPause", hl.dsp.exec_cmd(ipc .. " media pause"),    { locked = true })
hl.bind("XF86AudioPlay",  hl.dsp.exec_cmd(ipc .. " media play"),     { locked = true })
hl.bind("XF86AudioPrev",  hl.dsp.exec_cmd(ipc .. " media previous"), { locked = true })

-- Volume (PipeWire / WirePlumber)
-- NOTE: these duplicate the ipc-based volume binds above — carried over
-- verbatim from your source file, where the later `bindel =` line would win.
hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+"), { locked = true, repeating = true })
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"), { locked = true, repeating = true })
hl.bind("XF86AudioMute",        hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"), { locked = true, repeating = true })
hl.bind("XF86AudioMicMute",     hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"), { locked = true, repeating = true })

-- Brightness (brightnessctl)
hl.bind("XF86MonBrightnessUp",   hl.dsp.exec_cmd("brightnessctl set +10%"), { locked = true, repeating = true })
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("brightnessctl set 10%-"), { locked = true, repeating = true })

-- Media (playerctl)
hl.bind("XF86AudioNext",  hl.dsp.exec_cmd("playerctl next"),     { locked = true })
hl.bind("XF86AudioPause", hl.dsp.exec_cmd("playerctl pause"),    { locked = true })
hl.bind("XF86AudioPlay",  hl.dsp.exec_cmd("playerctl play"),     { locked = true })
hl.bind("XF86AudioPrev",  hl.dsp.exec_cmd("playerctl previous"), { locked = true })

-- hl.bind("SUPER + D", hl.dsp.exec_cmd(ipc .. " launcher toggle"))
hl.bind("SUPER + C", hl.dsp.exec_cmd(ipc .. " controlCenter toggle"))
hl.bind("SUPER + S", hl.dsp.exec_cmd(ipc .. " settings toggle"))
hl.bind("SUPER + L", hl.dsp.exec_cmd("hyprlock"))
hl.bind("SUPER + N", hl.dsp.exec_cmd(ipc .. " notifications toggleHistory"))
hl.bind("SUPER + W", hl.dsp.exec_cmd(ipc .. " wallpaper toggle"))
hl.bind("SUPER + SHIFT + D", hl.dsp.exec_cmd(ipc .. " plugin:todo togglePanel"))
