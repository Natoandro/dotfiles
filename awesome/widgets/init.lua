local wibox = require("wibox")
local gears = require("gears")
local awful = require("awful")
local beautiful = require("beautiful")
local theme = beautiful.get()

local _M = {
  mainmenu = require("widgets.mainmenu"),
  create_taglist = require("widgets.taglist"),
  create_tasklist = require("widgets.tasklist"),
}

function get_launcher_markup_from_state(state)
  if state.active_screen then
    return "<span foreground='#ffff00'>" .. os.getenv("USER") .. "</span>"
  else
    return "<span foreground='#888800'>" .. os.getenv("USER") .. "</span>"
  end
end

-- Launcher
function _M.create_launcher()
  local launcher = wibox.widget {
    widget = wibox.container.margin,
    buttons = gears.table.join(awful.button({}, 1, function()
      _M.mainmenu:toggle()
    end)),
    left = 10,
    right = 10,
  }

  launcher.widget = wibox.widget {
    widget = wibox.widget.textbox,
    markup = get_launcher_markup_from_state { active_screen = false },
    font = "monospace 9",
  }

  return launcher
end

function _M.update_launcher(launcher, state)
  launcher.widget.markup = get_launcher_markup_from_state(state)
end

-- Keyboard map indicator and switcher
_M.keyboardlayout = wibox.widget {
  {
    widget = awful.widget.keyboardlayout,
  },
  widget = wibox.container.margin,
  left = 10,
  right = 10,
  buttons = gears.table.join(awful.button({}, 1, function()
    _M.keyboardlayout.widget:next_layout()
  end)),
}

-- Create a textclock widget
_M.textclock = wibox.widget {
  {
    widget = wibox.widget.textclock,
    format = "%a %b %d %I:%M %p",
    font = "monospace bold 9",
  },
  widget = wibox.container.margin,
  left = 8,
  right = 8,
}

function _M.create_promptbox()
  local promptbox = wibox.widget {
    widget = wibox.container.margin,
    left = 8,
    right = 8,
  }
  promptbox.widget = awful.widget.prompt {
    fg = "#cccc00",
  }

  return promptbox
end

function _M.create_layoutbox(s)
  local layoutbox = awful.widget.layoutbox(s)
  layoutbox:buttons(gears.table.join(
    awful.button({}, 1, function()
      awful.layout.inc(1)
    end),
    awful.button({}, 3, function()
      awful.layout.inc(-1)
    end),
    awful.button({}, 4, function()
      awful.layout.inc(1)
    end),
    awful.button({}, 5, function()
      awful.layout.inc(-1)
    end)
  ))

  return wibox.widget {
    layoutbox,
    widget = wibox.container.margin,
    top = 4,
    bottom = 4,
    left = 8,
    right = 10,
  }
end

function _M.create_systray()
  return wibox.widget {
    {
      widget = wibox.widget.systray,
      base_size = 16,
    },
    widget = wibox.container.margin,
    color = theme.bg_systray,
    top = 4,
    bottom = 4,
    left = 12,
    right = 12,
  }
end

return _M
