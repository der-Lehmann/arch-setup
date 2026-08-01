-- Keep the internal screen enabled whenever no external monitor is connected,
-- even if the nwg-displays profile (monitors.lua) disables it.
--
-- How it works: this module is required *after* monitors.lua, so a monitor
-- rule added here overrides the nwg-displays one for the same output. The
-- decision is made at config load time based on the kernel's DRM connector
-- state; hotplug events simply trigger a config reload to re-evaluate.

local INTERNAL = "eDP-1"

local function is_internal(name)
    return name:sub(1, 3) == "eDP"
end

-- Reads /sys/class/drm instead of hl.get_monitors() because Hyprland's
-- monitor list excludes disabled outputs and is empty during startup load.
local function external_connected()
    local p = io.popen("grep -lx connected /sys/class/drm/card*-*/status 2>/dev/null")
    if not p then
        return false
    end
    local out = p:read("*a")
    p:close()
    for path in out:gmatch("[^\n]+") do
        if not path:find("eDP", 1, true) then
            return true
        end
    end
    return false
end

-- Load-time override: with no external screen attached, the nwg-displays
-- "eDP-1 disabled" rule would leave us without any display.
if not external_connected() then
    hl.monitor({
        output = INTERNAL,
        mode = "preferred",
        position = "auto",
        scale = "auto",
        disabled = false,
    })
end

-- Internal panel events are ignored: enabling/disabling eDP-1 via the rules
-- above fires these events too, which would otherwise cause a reload loop.
hl.on("monitor.removed", function(removed)
    if not is_internal(removed.name) and not external_connected() then
        hl.exec_cmd("hyprctl reload")
    end
end)

-- Re-plugging an external monitor restores the nwg-displays profile
-- (which may disable the internal screen again).
hl.on("monitor.added", function(added)
    if not is_internal(added.name) then
        hl.exec_cmd("hyprctl reload")
    end
end)
