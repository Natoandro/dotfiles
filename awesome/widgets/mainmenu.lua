local awful = require("awful")
local beautiful = require("beautiful")

-- Load Debian menu entries
local debian = require("debian.menu")
local has_fdo, freedesktop = pcall(require, "freedesktop")

local awesomemenu = {
  {
    "hotkeys",
    function()
      hotkeys_popup.show_help(nil, awful.screen.focused())
    end,
  },
  { "manual",      terminal .. " -e man awesome" },
  { "edit config", editor_cmd .. " " .. awesome.conffile },
  { "restart",     awesome.restart },
  {
    "quit",
    function()
      awesome.quit()
    end,
  },
}

local menu_awesome = { "awesome", awesomemenu, beautiful.awesome_icon }
local menu_terminal = { "open terminal", terminal }

if has_fdo then
  return freedesktop.menu.build {
    before = { menu_awesome },
    after = { menu_terminal },
  }
else
  return awful.menu {
    items = {
      menu_awesome,
      { "Debian", debian.menu.Debian_menu.Debian },
      menu_terminal,
    },
  }
end
