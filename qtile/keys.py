from libqtile.config import Key
from libqtile.lazy import lazy

import commands as cmd

mod = "mod4"
alt = "mod1"

keys = []

# Switch between windows
_keys_window_focus = [
    Key([mod], "h", lazy.layout.left(), desc="Move focus to left"),
    Key([mod], "l", lazy.layout.right(), desc="Move focus to right"),
    Key([mod], "j", lazy.layout.down(), desc="Move focus down"),
    Key([mod], "k", lazy.layout.up(), desc="Move focus up"),
    Key([mod], "Tab", lazy.layout.next(), desc="Move window focus to other window"),
]
keys.extend(_keys_window_focus)

# Window management
_keys_window = [
    Key([mod], "w", lazy.window.kill(), desc="Kill focused window"),
]
keys.extend(_keys_window)


# Window layout
_keys_window_layout = [
    # Move windows between left/right columns or move up/down in current stack.
    # Moving out of range in Columns layout will create new column.
    Key(
        [mod, "shift"],
        "h",
        lazy.layout.shuffle_left(),
        desc="Move window to the left",
    ),
    Key(
        [mod, "shift"],
        "l",
        lazy.layout.shuffle_right(),
        desc="Move window to the right",
    ),
    Key([mod, "shift"], "j", lazy.layout.shuffle_down(), desc="Move window down"),
    Key([mod, "shift"], "k", lazy.layout.shuffle_up(), desc="Move window up"),
    # Grow windows. If current window is on the edge of screen and direction
    # will be to screen edge - window would shrink.
    Key(
        [mod, "control"],
        "h",
        lazy.layout.grow_left(),
        desc="Grow window to the left",
    ),
    Key(
        [mod, "control"],
        "l",
        lazy.layout.grow_right(),
        desc="Grow window to the right",
    ),
    Key([mod, "control"], "j", lazy.layout.grow_down(), desc="Grow window down"),
    Key([mod, "control"], "k", lazy.layout.grow_up(), desc="Grow window up"),
    #
    Key([mod], "f", lazy.window.toggle_floating()),
    Key([mod, "shift"], "m", lazy.window.toggle_maximize()),
    Key([mod], "m", lazy.window.toggle_minimize()),
    Key([mod, "shift"], "f", lazy.window.bring_to_front()),
]
keys.extend(_keys_window_layout)

# Layout
_keys_layouts = [
    #
    Key([mod], "bracketright", lazy.layout.grow()),
    Key([mod], "bracketleft", lazy.layout.shrink()),
    Key([mod, "shift"], "n", lazy.layout.normalize()),
    Key([mod, "shift"], "o", lazy.layout.maximize()),
    # __
    Key([mod], "n", lazy.layout.normalize(), desc="Reset all window sizes"),
    # Toggle between split and unsplit sides of stack.
    # Split = all windows displayed
    # Unsplit = 1 window displayed, like Max layout, but still with
    # multiple stack panes
    Key(
        [mod, "shift"],
        "Return",
        lazy.layout.toggle_split(),
        desc="Toggle between split and unsplit sides of stack",
    ),
    # Toggle between different layouts as defined below
    Key([mod], "F1", lazy.next_layout(), desc="Toggle between layouts"),
    Key([mod, "shift"], "space", lazy.layout.flip()),
]
keys.extend(_keys_layouts)

_keys_window_screen = [
    Key(
        [mod, "shift"],
        "Left",
        lambda qtile: qtile.current_window.toscreen(
            (qtile.current_screen.index - 1) % qtile.num_screens()
        ),
    ),
    Key(
        [mod, "shift"],
        "Right",
        lambda qtile: qtile.current_window.toscreen(
            (qtile.current_screen.index + 1) % qtile.num_screens()
        ),
    ),
]
keys.extend(_keys_window_screen)

# qtile lifetime
_keys_qtile = [
    Key([mod, "control"], "r", lazy.reload_config(), desc="Reload the config"),
    Key([mod, "control", "shift"], "r", lazy.restart(), desc="Restart Qtile"),
    Key([mod, "control"], "q", lazy.shutdown(), desc="Shutdown Qtile"),
]
keys.extend(_keys_qtile)

# launcher
_keys_apps = [
    Key([mod], "Return", lazy.spawn(cmd.terminal), desc="Launch terminal"),
    Key([mod], "e", lazy.spawn(cmd.myFileManager), desc="File Manager"),
    Key([mod], "b", lazy.spawn("microsoft-edge")),
]
keys.extend(_keys_apps)

_keys_menus = [
    Key([mod], "r", lazy.spawn(cmd.menu_primary), desc="My primary menu"),
    Key([mod], "d", lazy.spawn(cmd.menu_secondary), desc="DMenu"),
    Key([mod, "shift"], "e", lazy.spawn(cmd.menu_fileBrowser), desc="File Browser"),
    Key([alt], "grave", lazy.spawn(cmd.menu_switcher), desc="Window switcher"),
    Key(
        [alt],
        "Tab",
        lazy.spawn(cmd.menu_switcherGroup),
        desc="Window switcher (group only)",
    ),
    Key([mod, "shift"], "Delete", lazy.spawn(cmd.menu_power), desc="Power options"),
]
keys.extend(_keys_menus)

_keys_widgets = [
    Key([mod], "space", lazy.widget["keyboardlayout"].next_keyboard(), desc="Next keyboard layout"),

        ]
keys.extend(_keys_widgets)


_keys_notify = [
    Key(
        [mod],
        "t",
        lazy.spawn(cmd.notify_dateTime),
        desc="Display date and time in a notification",
    ),
]
keys.extend(_keys_notify)

_keys_media = [
    Key([], "XF86AudioRaiseVolume", lazy.spawn("pactl set-sink-volume @DEFAULT_SINK@ +5%")),
    Key([], "XF86AudioLowerVolume", lazy.spawn("pactl set-sink-volume @DEFAULT_SINK@ -5%")),
    Key([], "XF86AudioMute", lazy.spawn("pactl set-sink-mute @DEFAULT_SINK@ toggle")),
    Key([], "XF86AudioPlay", lazy.spawn("playerctl play-pause"), desc="Play/Pause player"),
    Key([], "XF86AudioNext", lazy.spawn("playerctl next"), desc="Skip to next"),
    Key([], "XF86AudioPrev", lazy.spawn("playerctl previous"), desc="Skip to previous"),
]
keys.extend(_keys_media)

_keys_power = [
    Key([mod], "L", lazy.spawn("slock"))
]
keys.extend(_keys_power)

