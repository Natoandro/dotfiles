local gears = require("gears")
local awful = require("awful")
local widgets = require("widgets")

local globalbuttons = gears.table.join(
  awful.button({}, 3, function()
    widgets.mainmenu:toggle()
  end),
  awful.button({}, 4, awful.tag.viewnext),
  awful.button({}, 5, awful.tag.viewprev)
)

return globalbuttons
