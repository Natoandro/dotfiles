local awful = require("awful")

local commands = {
  "picom",
  "systemctl --user start docker-desktop",
  "setxkbmap us,fr",
  "xautolock -time 10 -locker ~/.config/awesome/autolock.sh -notify 30 -notifier 'notify-send -u critical -t 20000 -- \"Locking screen in 30 seconds\"'",
}

return function()
  for _, command in ipairs(commands) do
    awful.spawn.once(command, {})
  end

  -- awful.spawn.single_instance("nm-tray")
end
