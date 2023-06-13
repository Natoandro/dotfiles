from libqtile.utils import guess_terminal

bash = lambda cmd: f"bash -c '{cmd}'"

terminal = guess_terminal() or "alacritty"
myFileManager = f"{terminal} -e vifm"


menu_primary = 'rofi -modi "drun,run" -show drun -show-icons'
# mySecondaryMenu = "dmenu_run -fn 'JetBrains Mono-10' -lr 1.5 -p 'Run:'"
menu_secondary = "dmenu_run -fn 'JetBrains Mono-10' -p 'Run:'"
menu_fileBrowser = "rofi -show filebrowser"
menu_switcher = 'rofi -modi "window,windowcd" -show window -show-icons'
menu_switcherGroup = 'rofi -modi "window,windowcd" -show windowcd -show-icons'
menu_power = bash("runner ~/dotfiles/runner.toml power")


notify_dateTime = bash('dunstify "$(date "+%a %d %b %Y")" "$(date "+%T")"')
