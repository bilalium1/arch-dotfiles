-- Converted from classic hyprland.conf to the new Lua config format
-- (Hyprland v0.55+). Refer to the wiki for more information.
-- https://wiki.hypr.land/Configuring/Start/

-- Please note not all available settings / options are set here.
-- For a full list, see the wiki

-- You can split this configuration into multiple files.
-- Create your files separately and then require() them, e.g.:
-- require("myColors")

------------------
---- MONITORS ----
------------------

-- See https://wiki.hypr.land/Configuring/Basics/Monitors/
hl.monitor({
    output   = "",
    mode     = "1920x1080@60",
    position = "0x0",
    scale    = 1,
})

---------------------
---- MY PROGRAMS ----
---------------------

local terminal    = "kitty"
local fileManager = "thunar"
local menu        = "rofi -show drun"

-------------------
---- AUTOSTART ----
-------------------

-- See https://wiki.hypr.land/Configuring/Basics/Autostart/
hl.on("hyprland.start", function()
    hl.exec_cmd("zen-browser")
    hl.exec_cmd("bongocat")
    hl.exec_cmd("waybar")
    hl.exec_cmd("awww-daemon")
    hl.exec_cmd("spotify-launcher")
    hl.exec_cmd("bash ~/.scripts/spot_cover.sh")
    hl.exec_cmd("hyprpm reload")
    -- hl.exec_cmd("qs -c noctalia-shell")
end)

-------------------------------
---- ENVIRONMENT VARIABLES ----
-------------------------------

-- See https://wiki.hypr.land/Configuring/Advanced-and-Cool/Environment-variables/
hl.env("XDG_DOWNLOAD_DIR", "$HOME/downs")

-- NOTE: this sourced file needs to be rewritten in Lua too (e.g. gtk-env.lua)
-- before require() will work on it.
-- require("configs.gtk-env")

hl.env("XCURSOR_THEME", "Wii")
hl.env("XCURSOR_SIZE", "23")

-----------------------
----- PERMISSIONS -----
-----------------------

-- See https://wiki.hypr.land/Configuring/Advanced-and-Cool/Permissions/
-- Please note permission changes here require a Hyprland restart and are not
-- applied on-the-fly, for security reasons.

-- hl.config({
--     ecosystem = {
--         enforce_permissions = true,
--     },
-- })

-- hl.permission("/usr/(bin|local/bin)/grim", "screencopy", "allow")
-- hl.permission("/usr/(lib|libexec|lib64)/xdg-desktop-portal-hyprland", "screencopy", "allow")
hl.permission("/usr/(bin|local/bin)/hyprpm", "plugin", "allow")

-----------------------
------ PLUGINS --------
-----------------------

-- The plugin must be loaded before its config keys exist, or you'll get an
-- "unknown config key" error even with correct syntax below.
-- Update this path to wherever dynamic-cursors.so actually lives on your
-- system (hyprpm typically installs to ~/.local/share/hyprpm, distro packages
-- often to /usr/lib/hyprland-plugins/).

if hl.plugin.dynamic_cursors then
	hl.config({
		plugin = {
			dynamic_cursors = {
				enabled = true,
				mode = "stretch",
			},
		},
	})
end

-----------------------
---- LOOK AND FEEL ----
-----------------------

-- NOTE: the wallust *template* still needs to be rewritten in Lua-output form
-- (done — see wallust-hypr.lua.template) and your wallust.toml `target` for
-- this entry updated to point at a .lua path, e.g.
-- ~/.config/hypr/configs/wallust-hypr.lua, so wallust writes Lua instead of
-- the old hyprlang syntax on every wallpaper change.
--local colors = require("configs.wallust-hypr")

-- Refer to https://wiki.hypr.land/Configuring/Basics/Variables/
hl.config({
    general = {
        gaps_in = 2,
        gaps_out = 15,

        border_size = 1,

        col = {
            active_border   = "rgba(595959aa)",
            inactive_border = "rgba(00000000)",
        },

        -- Set to true to enable resizing windows by clicking and dragging on borders/gaps
        resize_on_border = false,

        -- Please see https://wiki.hypr.land/Configuring/Advanced-and-Cool/Tearing/ before enabling
        allow_tearing = false,

        layout = "dwindle",
    },

    decoration = {
        -- screen_shader = "~/.config/hypr/shaders/scanline.glsl",

        rounding = 4,
        rounding_power = 26,

        -- Change transparency of focused and unfocused windows
        active_opacity = 1.0,
        inactive_opacity = 0.8,

        shadow = {
            enabled = true,
            range = 5,
            offset = { 0, 1 },
            color = "rgba(080001aa)",
            color_inactive = "rgba(02000159)",
        },

        blur = {
            enabled = true,
            size = 5,
            passes = 5,
            contrast = 2.0,
            brightness = 0.8,
            noise = 0.005,
            new_optimizations = true,
            vibrancy = 1.2,
        },
    },

    animations = {
        enabled = true,
    },
})

-- Default curves, see https://wiki.hypr.land/Configuring/Advanced-and-Cool/Animations/
hl.curve("easeOutQuint",   { type = "bezier", points = { {0.23, 1},    {0.32, 1} } })
hl.curve("easeInOutCubic", { type = "bezier", points = { {0.65, 0.05}, {0.36, 1} } })
hl.curve("linear",         { type = "bezier", points = { {0, 0},       {1, 1} } })
hl.curve("almostLinear",   { type = "bezier", points = { {0.5, 0.5},   {0.75, 1} } })
hl.curve("quick",          { type = "bezier", points = { {0.15, 0},    {0.1, 1} } })

-- Default animations, see https://wiki.hypr.land/Configuring/Advanced-and-Cool/Animations/
hl.animation({ leaf = "global",        enabled = true, speed = 10,   bezier = "default" })
hl.animation({ leaf = "border",        enabled = true, speed = 5.39, bezier = "easeOutQuint" })
hl.animation({ leaf = "windows",       enabled = true, speed = 4.79, bezier = "easeOutQuint" })
hl.animation({ leaf = "windowsIn",     enabled = true, speed = 10,   bezier = "easeOutQuint", style = "slide" })
hl.animation({ leaf = "windowsOut",    enabled = true, speed = 4,    bezier = "quick",         style = "slide" })
hl.animation({ leaf = "fadeIn",        enabled = true, speed = 1.73, bezier = "almostLinear" })
hl.animation({ leaf = "fadeOut",       enabled = true, speed = 1.46, bezier = "almostLinear" })
hl.animation({ leaf = "fade",          enabled = true, speed = 3.03, bezier = "quick" })
hl.animation({ leaf = "layers",        enabled = true, speed = 3.81, bezier = "easeOutQuint" })
hl.animation({ leaf = "layersIn",      enabled = true, speed = 4,    bezier = "easeOutQuint", style = "fade" })
hl.animation({ leaf = "layersOut",     enabled = true, speed = 1.5,  bezier = "linear",        style = "fade" })
hl.animation({ leaf = "fadeLayersIn",  enabled = true, speed = 1.79, bezier = "almostLinear" })
hl.animation({ leaf = "fadeLayersOut", enabled = true, speed = 1.39, bezier = "almostLinear" })
hl.animation({ leaf = "workspaces",    enabled = true, speed = 4,    bezier = "easeOutQuint", style = "fade" })
hl.animation({ leaf = "workspacesIn",  enabled = true, speed = 10,   bezier = "easeOutQuint", style = "slide" })
hl.animation({ leaf = "workspacesOut", enabled = true, speed = 5,    bezier = "easeOutQuint", style = "slide" })
hl.animation({ leaf = "zoomFactor",    enabled = true, speed = 7,    bezier = "quick" })

-- Ref https://wiki.hypr.land/Configuring/Basics/Workspace-Rules/
-- "Smart gaps" / "No gaps when only"
-- uncomment all if you wish to use that.
-- hl.workspace_rule({ workspace = "w[tv1]", gaps_out = 0, gaps_in = 0 })
-- hl.workspace_rule({ workspace = "f[1]", gaps_out = 0, gaps_in = 0 })
-- hl.window_rule({
--     name = "no-gaps-wtv1",
--     match = { float = false, workspace = "w[tv1]" },
--     border_size = 0,
--     rounding = 0,
-- })
-- hl.window_rule({
--     name = "no-gaps-f1",
--     match = { float = false, workspace = "f[1]" },
--     border_size = 0,
--     rounding = 0,
-- })

hl.workspace_rule({ workspace = "s[true]", gaps_in = 4, gaps_out = 80 })

-- See https://wiki.hypr.land/Configuring/Layouts/Dwindle-Layout/ for more
hl.config({
    dwindle = {
        preserve_split = true, -- You probably want this
    },
})

-- See https://wiki.hypr.land/Configuring/Layouts/Master-Layout/ for more
hl.config({
    master = {
        new_status = "master",
    },
})

----------------
---- MISC ----
----------------

hl.config({
    misc = {
        force_default_wallpaper = -1, -- Set to 0 or 1 to disable the anime mascot wallpapers
        disable_hyprland_logo = false, -- If true disables the random Hyprland logo / anime girl background
    },
})

---------------
---- INPUT ----
---------------

hl.config({
    input = {
        kb_layout = "us",
        kb_variant = "",
        kb_model = "",
        kb_options = "",
        kb_rules = "",

        follow_mouse = 1,
        accel_profile = "adaptive",
        force_no_accel = false,

        sensitivity = 0, -- -1.0 - 1.0, 0 means no modification.

        touchpad = {
            natural_scroll = false,
        },
    },
})

-- See https://wiki.hypr.land/Configuring/Basics/Binds/#gestures
hl.gesture({
    fingers = 3,
    direction = "horizontal",
    action = "workspace",
})

-- Example per-device config
-- See https://wiki.hypr.land/Configuring/Advanced-and-Cool/Devices/ for more
hl.device({
    name = "epic-mouse-v1",
    sensitivity = -0.5,
})

---------------------
---- KEYBINDINGS ----
---------------------

-- NOTE: this sourced file needs to be rewritten in Lua too (e.g. keybinds.lua),
-- using hl.bind(...) calls, before require() will work on it.
require("configs.keybindslua")

--------------------------------
---- WINDOWS AND WORKSPACES ----
--------------------------------

-- See https://wiki.hypr.land/Configuring/Basics/Window-Rules/
-- and https://wiki.hypr.land/Configuring/Basics/Workspace-Rules/

hl.window_rule({
    -- Ignore maximize requests from all apps. You'll probably like this.
    name = "suppress-maximize-events",
    match = { class = ".*" },
    suppress_event = "maximize",
})

hl.window_rule({
    name = "focus-thing",
    match = { focus = true },
})

-- Layer rules — NOTE: not shown in Hyprland's official Lua example at the time
-- of writing. This is a best-effort mapping of the classic `layerrule =` lines;
-- verify field names (blur, ignore_alpha, animation) against current docs.
hl.layer_rule({ match = { namespace = "waybar" }, blur = true })
hl.layer_rule({ match = { namespace = "waybar" }, ignore_alpha = 0.3 })
hl.layer_rule({ match = { namespace = "waybar" }, animation = "popin 90%" })
hl.layer_rule({ match = { namespace = "rofi" }, blur = true })
hl.layer_rule({ match = { namespace = "rofi" }, ignore_alpha = 0.5 })
hl.layer_rule({ match = { namespace = "rofi" }, animation = "popin 90%" })

hl.window_rule({
    -- Fix some dragging issues with XWayland
    name = "fix-xwayland-drags",
    match = {
        class = "^$",
        title = "^$",
        xwayland = true,
        float = true,
        fullscreen = false,
        pin = false,
    },
    no_focus = true,
})

-- Hyprland-run windowrule
hl.window_rule({
    name = "quickshell-float",
    match = { class = "^(org.quickshell)$" },

    persistent_size = true,
    decorate = false,
    rounding = 5,
    fullscreen = false,
    center = true,
    float = true,
    opaque = false,
    opacity = 1,
})

hl.window_rule({
    name = "move-hyprland-run",
    match = { class = "hyprland-run" },
    move = "20 monitor_h-120",
    float = true,
})

hl.window_rule({
    name = "kittyinv",
    match = { class = "kitty" },
    opacity = 0.8,
})

hl.window_rule({
    name = "code-opacity",
    match = { class = "codium" },
    opacity = 0.87,
})

hl.window_rule({
    name = "zed-opacity",
    match = { class = "dev.zed.Zed" },
    opacity = 0.98,
})

hl.window_rule({
    name = "spotify-op",
    match = { class = "Spotify" },
    opacity = 0.85,
})

-- Original single rule matched two classes; split since `match` takes one
-- value per key in the Lua API.
hl.window_rule({
    name = "gtk-op-xdg-portal",
    match = { class = "xdg-desktop-portal-gtk" },
    opacity = 0.8,
    animation = "popin 80%",
})

hl.window_rule({
    name = "gtk-op-thunar",
    match = { class = "thunar" },
    opacity = 0.8,
    animation = "popin 80%",
})

hl.window_rule({
    name = "obs-opacity",
    match = { class = "obsidian" },
    opacity = 0.85,
})

hl.window_rule({
    name = "disc-obs",
    match = { class = "discord" },
    opacity = 0.8,
})
