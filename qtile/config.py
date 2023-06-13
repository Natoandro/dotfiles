# Copyright (c) 2010 Aldo Cortesi
# Copyright (c) 2010, 2014 dequis
# Copyright (c) 2012 Randall Ma
# Copyright (c) 2012-2014 Tycho Andersen
# Copyright (c) 2012 Craig Barnes
# Copyright (c) 2013 horsik
# Copyright (c) 2013 Tao Sauvage

# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.

from libqtile import bar, layout, widget, hook, qtile
from libqtile.config import Click, Drag, DropDown, Group, Key, Match, ScratchPad, Screen
from libqtile.lazy import lazy

# from libqtile.log_utils import logger
import subprocess
from spotify import Spotify
from custom_widgets import WindowName
import os
from itertools import takewhile

from keys import keys, mod
from commands import terminal
import commands as cmd

subprocess.Popen(["bash", os.path.expanduser("~/.config/qtile/startup.sh")])


# def send_current_window(qtile):
#     win_info = qtile.current_window.info()
#     name = win_info["name"]
#     status = (
#         "minimized" if win_info["minimized"]
#         else "maximized" if win_info["maximized"]
#         else "floating" if win_info["floating"]
#         else "tiled"
#     )
#     cur_group = qtile.current_group
#     group = f"Group: {cur_group.name}"
#     screen_info = qtile.current_screen.cmd_info()
#     screen = f"Screen {screen_info['index'] + 1} ({screen_info['width']}x{screen_info['height']})"
#     qtile.cmd_spawn(["dunstify", screen, f"{group}\nWindow: {name} (<u>{status}</u>)"])
#

# keys = [
#     # A list of available commands that can be bound to keys can be found
#     # at https://docs.qtile.org/en/latest/manual/config/lazy.html
#     # Key([mod], "r", lazy.spawncmd(), desc="Spawn a command using a prompt widget"),
#
#     # Mine
#
#     # Key([mod, "shift"], "t", lazy.function(send_current_window), desc="Dispaly current window title in a notification"),
#
#     # Key([mod, "shift"], "r", lazy.layout.reset()),
#     # Key([mod, "alt"], "h", lazy.window.toscreen(-1)),
#     # Key([mod, "shift"], "Right", lazy.window.toscreen(1)),
#
# ]


def to_prev_screen(qtile, move_window=True):
    num_screens = len(qtile.screens)
    i = qtile.screens.index(qtile.current_screen)
    target = (i - 1) % num_screens
    if move_window:
        group = qtile.screens[target].group.name
        qtile.current_window.togroup(group)
    qtile.cmd_to_screen(target)


def to_next_screen(qtile, move_window=True):
    num_screens = len(qtile.screens)
    i = qtile.screens.index(qtile.current_screen)
    target = (i + 1) % num_screens
    if move_window:
        group = qtile.screens[target].group.name
        qtile.current_window.togroup(group)
    qtile.cmd_to_screen(target)


keys.extend(
    [
        Key(
            [mod, "shift"],
            "p",
            lazy.function(to_prev_screen),
            desc="Move current window to previous screen",
        ),
        Key(
            [mod, "shift"],
            "n",
            lazy.function(to_next_screen),
            desc="Move current window to next screen",
        ),
        Key(
            [mod],
            "p",
            lazy.function(to_prev_screen, move_window=False),
            desc="Move current window to previous screen",
        ),
        Key(
            [mod],
            "n",
            lazy.function(to_next_screen, move_window=False),
            desc="Move current window to next screen",
        ),
    ]
)


def group_switcher(qtile):
    current_group = qtile.current_group
    groups = takewhile(lambda g: "Group" in type(g).__name__, qtile.groups)
    p = subprocess.run(
        ["rofi", "-dmenu", "-format", "i", "-select", current_group.name],
        stdout=subprocess.PIPE,
        input="\n".join(
            f"{idx + 1}: {group.name}" for (idx, group) in enumerate(groups)
        ),
        text=True,
    )
    if p.returncode == 0:
        selected_group = qtile.groups[int(p.stdout)]
        qtile.current_screen.cmd_toggle_group(selected_group.name)


keys.extend(
    [
        Key(
            [mod],
            "grave",
            lazy.function(group_switcher),
            desc="Open rofi group switcher",
        ),
    ]
)


def toggle_bar(qtile):
    qtile.cmd_hide_show_bar()


keys.extend([Key([mod], "F8", lazy.function(toggle_bar), desc="Toggle bar visibility")])

# icons        


group_names = [
    " term",
    " code",
    "💻computing",
    " internet",
    " file",
    " social",
    # "🎜 media",
    "🎧music",
    "🎥video",
    " work",
    "📅time",
    "sys",
    " misc",
]
group_matches = {}
group_spawns = {"chat": "slack"}

groups = [
    Group(name, spawn=group_spawns.get(name), label=name[0:1]) for name in group_names
]

group_keys = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "0", "minus", "equal"]

for i, g in enumerate(groups):
    keys.extend(
        [
            # mod1 + letter of group = switch to group
            Key(
                [mod],
                group_keys[i],
                lazy.group[g.name].toscreen(),
                desc="Switch to group {}".format(g.name),
            ),
            # mod1 + shift + letter of group = switch to & move focused window to group
            Key(
                [mod, "shift"],
                group_keys[i],
                lazy.window.togroup(g.name, switch_group=True),
                desc="Switch to & move focused window to group {}".format(g.name),
            ),
            # Or, use below if you prefer not to switch to that group.
            # # mod1 + shift + letter of group = move focused window to group
            # Key([mod, "shift"], i.name, lazy.window.togroup(i.name),
            #     desc="move focused window to group {}".format(i.name)),
        ]
    )

keys.extend(
    [
        Key([mod], "F11", lazy.group["Spad"].dropdown_toggle("term")),
    ]
)

spad_commons = dict(
    opacity=1,
    y=0.2,
    height=0.6,
    on_focus_lost_hide=True,
    warp_pointer=True,
)

spad = ScratchPad(
    "Spad",
    [
        DropDown(
            "term",
            terminal + " -T 'Scratchpad terminal' -e tmux new-session -A -s 'spad'",
            **spad_commons,
        ),
        DropDown(
            "top",
            terminal + " -T 'Btop' -e btop",
            **spad_commons,
        ),
    ],
)

groups.append(spad)
keys.extend(
    [
        Key([mod], "F11", lazy.group["Spad"].dropdown_toggle("term")),
        Key([mod], "F12", lazy.group["Spad"].dropdown_toggle("top")),
    ]
)


@hook.subscribe.startup_complete
def startup():
    qtile.cmd_simulate_keypress([mod], "F12")
    qtile.cmd_simulate_keypress([mod], "F12")


layouts = [
    # layout.Columns(border_focus_stack=["#d75f5f", "#8f3d3d"], border_width=4, margin=4, gap=4),
    layout.Max(),
    layout.MonadTall(
        margin=6,
        gap=6,
        border_width=4,
        border_normal="#110011",
        border_focus="#aaaaaa",
    ),
    # Try more layouts by unleashing below layouts.
    # layout.Stack(num_stacks=2),
    # layout.Bsp(),
    # layout.Matrix(),
    # layout.MonadWide(),
    # layout.RatioTile(),
    # layout.Tile(),
    # layout.TreeTab(),
    # layout.VerticalTile(),
    # layout.Zoomy(),
]

widget_defaults = dict(
    font="sans",
    fontsize=12,
    padding=3,
)
extension_defaults = widget_defaults.copy()


group_box_config = dict(
    highlight_method="line", inactive="ffffff60", font="JetBrains Mono", fontsize=14
)
window_name_config = dict(
    foreground="aa88ff",
    txt_floating="🗗 ",
    mouse_callbacks={
        "Button1": lazy.window.bring_to_front(),
        "Button2": lazy.window.toggle_maximize(),
        "Button3": lazy.window.toggle_minimize(),
    },
)
window_count_config = dict(
    foreground="888888",
    fmt="Windows: {}",
    mouse_callbacks={
        "Button1": lazy.spawn(cmd.menu_switcherGroup),
        "Button3": lazy.layout.next(),  # TODO next window (include all windows in the cycle)
    },
)
task_list_config = dict(
    highlight_method="block", txt_floating="🗗 ", txt_maximized="🗖 ", txt_minimized="🗕 "
)
current_screen_config = dict(
    active_text="•",
    inactive_text="•",
    fontsize=20,
    mouse_callbacks={"Button1": lazy.spawn(cmd.menu_primary)},
)


def sp(length=10):
    return widget.Spacer(length=length)


screens = [
    Screen(
        top=bar.Bar(
            [
                sp(),
                widget.CurrentScreen(**current_screen_config),
                widget.GroupBox(**group_box_config),
                WindowName(**window_name_config),
                widget.WindowCount(**window_count_config),
                # widget.Spacer(),
                # widget.Prompt(),
                # widget.Spacer(),
                # Spotify(play_icon="♫", foreground="ffff00"),
                # widget.Spacer(length=10),
                # widget.TaskList(**task_list_config),
                widget.Mpris2(foreground="ffff00"),
                # widget.CurrentLayout(),
                widget.CPUGraph(
                    border_width=1,
                    line_width=2,
                    mouse_callbacks={
                        "Button1": lazy.spawn(f"{terminal} -e htop"),
                        "Button3": lazy.spawn("gnome-system-monitor"),
                    },
                ),
                widget.MemoryGraph(border_width=1, line_width=2),
                widget.Net(
                    font="monospace", foreground="66aa66", format="U {up} D {down}"
                ),
                widget.Systray(),
                # widget.PulseVolume(fmt="🔊{}"),
                widget.Volume(fmt="🔊{}"),
                sp(),
                widget.KeyboardLayout(
                    configured_keyboards=["us", "fr"], foreground="aaaaaa"
                ),
                sp(),
                widget.Clock(format="%Y/%m/%d %a %I:%M %p"),
                widget.CurrentLayoutIcon(scale=0.6),
                widget.Wallpaper(
                    label="WP", foreground="00aa00", random_selection=True
                ),
                sp(),
            ],
            32,
            background="#00000090",
            margin=8,
        ),
        # wallpaper="~/wallpapers/001.jpg",
        # wallpaper_mode="stretch",
    ),
    Screen(
        # top=bar.Bar(
        #     [
        #         sp(),
        #         widget.CurrentScreen(**current_screen_config),
        #         widget.GroupBox(**group_box_config),
        #         # widget.Prompt(),
        #         widget.WindowName(**window_name_config),
        #         widget.WindowCount(**window_count_config),
        #         widget.Chord(
        #             chords_colors={
        #                 "launch": ("#ff0000", "#ffffff"),
        #             },
        #             name_transform=lambda name: name.upper(),
        #         ),
        #         # widget.Spacer(),
        #         # widget.TaskList(**task_list_config),
        #         # NB Systray is incompatible with Wayland, consider using StatusNotifier instead
        #         # widget.StatusNotifier(),
        #         # widget.Clock(format="%Y-%m-%d %a %I:%M %p"),
        #         # widget.QuickExit(),
        #         widget.CurrentLayoutIcon(scale=0.66),
        #         sp(),
        #     ],
        #     28,
        #     background="#00000090"
        #     # border_width=[2, 0, 2, 0],  # Draw top and bottom borders
        #     # border_color=["ff00ff", "000000", "ff00ff", "000000"]  # Borders are magenta
        # ),
        # wallpaper="~/wallpapers/001.jpg",
        # wallpaper_mode="stretch",
    ),
]


# @hook.subscribe.client_focus
# def on_client_focus(window):
#     logger.warn(f"on focus: Window={window}")
#     qtile.current_window.bring_to_front()
#     # window.cmd_bring_to_front()


# Drag floating layouts.
mouse = [
    Drag(
        [mod],
        "Button1",
        lazy.window.set_position_floating(),
        start=lazy.window.get_position(),
    ),
    Drag(
        [mod], "Button3", lazy.window.set_size_floating(), start=lazy.window.get_size()
    ),
    Click([mod], "Button2", lazy.window.bring_to_front()),
]

dgroups_key_binder = None
dgroups_app_rules = []  # type: list
follow_mouse_focus = True
bring_front_click = False
cursor_warp = True
floating_layout = layout.Floating(
    float_rules=[
        # Run the utility of `xprop` to see the wm class and name of an X client.
        *layout.Floating.default_float_rules,
        Match(wm_class="confirmreset"),  # gitk
        Match(wm_class="makebranch"),  # gitk
        Match(wm_class="maketag"),  # gitk
        Match(wm_class="ssh-askpass"),  # ssh-askpass
        Match(wm_class="FpvlApp"),
        Match(title="branchdialog"),  # gitk
        Match(title="pinentry"),  # GPG key password entry
    ],
    border_focus="#555",
    border_width=4,
)
auto_fullscreen = True
focus_on_window_activation = "smart"
reconfigure_screens = True

# If things like steam games want to auto-minimize themselves when losing
# focus, should we respect this or not?
auto_minimize = True

# When using the Wayland backend, this can be used to configure input devices.
wl_input_rules = None

# XXX: Gasp! We're lying here. In fact, nobody really uses or cares about this
# string besides java UI toolkits; you can see several discussions on the
# mailing lists, GitHub issues, and other WM documentation that suggest setting
# this string if your java app doesn't work correctly. We may as well just lie
# and say that we're a working one by default.
#
# We choose LG3D to maximize irony: it is a 3D non-reparenting WM written in
# java that happens to be on java's whitelist.
wmname = "LG3D"
