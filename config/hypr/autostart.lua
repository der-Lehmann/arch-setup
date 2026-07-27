-- See https://wiki.hypr.land/Configuring/Basics/Autostart/

hl.on("hyprland.start", function()
    hl.exec_cmd("uwsm app -- waybar")
    hl.exec_cmd("uwsm app -- hyprpaper")
    hl.exec_cmd("uwsm app -- elephant")
    hl.exec_cmd("uwsm app -- walker --gapplication-service")
    hl.exec_cmd("uwsm app -- hypridle")
    hl.exec_cmd("uwsm app -- hyprsunset")
    hl.exec_cmd("uwsm app -- dunst")
    hl.exec_cmd("uwsm app -- nm-applet --indicator")
end)
