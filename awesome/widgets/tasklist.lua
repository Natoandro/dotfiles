local wibox = require("wibox")
local gears = require("gears")
local awful = require("awful")

local tasklist_buttons = gears.table.join(
  awful.button({}, 1, function(c)
    if c == client.focus then
      c.minimized = true
    else
      c:emit_signal("request::activate", "tasklist", { raise = true })
    end
  end),
  awful.button({}, 3, function()
    awful.menu.client_list { theme = { width = 250 } }
  end),
  awful.button({}, 4, function()
    awful.client.focus.byidx(1)
  end),
  awful.button({}, 5, function()
    awful.client.focus.byidx(-1)
  end)
)

icon_template = {
  {
    id = "icon_role",
    widget = wibox.widget.imagebox,
  },
  top = 5,
  bottom = 5,
  right = 10,
  widget = wibox.container.margin,
}

text_template = {
  id = "text_role",
  widget = wibox.widget.textbox,
}

return function(s)
  return awful.widget.tasklist {
    screen = s,
    filter = awful.widget.tasklist.filter.currenttags,
    buttons = tasklist_buttons,
    layout = {
      layout = wibox.layout.fixed.horizontal,
      spacing = 4,
    },
    widget_template = {
      {
        {
          {
            icon_template,
            text_template,
            layout = wibox.layout.fixed.horizontal,
          },
          left = 10,
          right = 10,
          widget = wibox.container.margin,
        },
        id = "background_role",
        widget = wibox.container.background,
      },
      widget = wibox.container.constraint,
      width = 240,
    },
  }
end
