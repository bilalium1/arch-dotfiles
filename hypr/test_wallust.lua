-- test_wallust.lua

local ok, cfg = pcall(require, "configs.wallust-hypr")

if not ok then
    print("failed to load configs.wallust-hypr")
    os.exit(1)
end

local colors = cfg.colors or cfg

local missing = {}

for i = 0, 15 do
    local key = "color" .. i
    if colors[key] == nil then
        table.insert(missing, key)
    end
end

-- also check common named ones
local extra = { "background", "foreground", "cursor" }
for _, k in ipairs(extra) do
    if colors[k] == nil then
        table.insert(missing, k)
    end
end

if #missing == 0 then
    print("all colors exist")
else
    print("missing colors:")
    for _, k in ipairs(missing) do
        print(" - " .. k)
    end
end
