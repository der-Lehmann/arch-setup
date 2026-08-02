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

-- The nwg-displays profile (monitors.lua) is machine-generated, so its shape
-- is predictable. Returns true when it disables the internal screen.
local function profile_disables_internal()
    local f = io.open(os.getenv("HOME") .. "/.config/hypr/monitors.lua")
    if not f then
        return false
    end
    local content = f:read("*a")
    f:close()
    for block in content:gmatch("hl%.monitor%s*(%b())") do
        if block:find('output%s*=%s*"eDP') and block:find("disabled%s*=%s*true") then
            return true
        end
    end
    return false
end

-- Load-time override: with no external screen attached, the nwg-displays
-- "eDP-1 disabled" rule would leave us without any display.
-- Only override in that case — an unconditional rule here would clobber the
-- profile's mode/position/scale for the internal screen (a later rule for the
-- same output fully replaces the earlier one).
if not external_connected() and profile_disables_internal() then
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

-- ThinkPad display key (Fn+F7): toggle the internal display on/off.
-- hl.get_monitors() only lists enabled monitors, so absence means "off".
hl.bind("XF86Display", function()
    local internal_on = false
    local externals = 0
    for _, mon in ipairs(hl.get_monitors()) do
        if is_internal(mon.name) then
            internal_on = true
        else
            externals = externals + 1
        end
    end

    if internal_on then
        -- Never disable the only active display
        if externals > 0 then
            hl.monitor({ output = INTERNAL, disabled = true })
        end
    else
        hl.monitor({
            output = INTERNAL,
            mode = "preferred",
            position = "auto",
            scale = "auto",
            disabled = false,
        })
    end
end, { locked = true })
