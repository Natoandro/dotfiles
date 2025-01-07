import XMonad

import XMonad.Util.EZConfig
import XMonad.Util.Ungrab
import XMonad.Util.Loggers
import XMonad.Util.SpawnOnce
import XMonad.Layout.ThreeColumns
import XMonad.Layout.Magnifier
import XMonad.Hooks.EwmhDesktops
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.StatusBar
import XMonad.Hooks.StatusBar.PP

main :: IO ()
main = xmonad
     . ewmhFullscreen
     . ewmh
     . withEasySB (statusBarProp "xmobar" (pure myXmobarPP)) defToggleStrutsKey
     $ myConfig

myTerminal :: String
myTerminal = "alacritty"

myConfig = def
    { modMask = mod4Mask
    , layoutHook = myLayout
    , startupHook = myStartupHook
    , terminal = myTerminal
    }
  `additionalKeys`
    [ ((0, 0x1008FF11), spawn "amixer -q sset Master 2%-")
    , ((0, 0x1008FF13), spawn "amixer -q sset Master 2%+")
    , ((0, 0x1008FF12), spawn "amixer set Master toggle")
    ]
  `additionalKeysP`
    [ ("M-C-s", unGrab *> spawn "scrot -s")
    , ("M-f", spawn "firefox-esr")
    -- , ("M-t", spawn "alacritty")
    , ("M-S-p", spawn "rofi -show drun")
    , ("M-S-z", spawn "xscreensaver-command -lock")
    ]


myLayout = tiled ||| Mirror tiled ||| Full ||| threeCol
  where
    threeCol = magnifiercz' 1.3 $ ThreeColMid nmaster delta ratio
    tiled = Tall nmaster delta ratio
    nmaster = 1
    ratio = 1/2
    delta = 3/10

myXmobarPP :: PP
myXmobarPP = def
    { ppSep = magenta " • "
    , ppTitleSanitize = xmobarStrip
    , ppCurrent = wrap "" "" . xmobarBorder "Top" "#8be9fd" 2
    , ppHidden = white . wrap "" ""
    -- , ppHiddenNoWindows = lowWhite . wrap "" ""
    , ppUrgent = red . wrap (yellow "!") (yellow "!")
    , ppOrder = \[ws, l, _, wins] -> [ws, l, wins]
    , ppExtras = [logTitles formatFocused formatUnfocused]
    }
  where
    formatFocused = wrap (white "[") (white "]") . magenta . ppWindow
    formatUnfocused = wrap (lowWhite "[") (lowWhite "]") . lowWhite . ppWindow

    ppWindow :: String -> String
    ppWindow = xmobarRaw . (\w -> if null w then "untitled" else w) . shorten 30

    blue, magenta, white, yellow, red, lowWhite :: String -> String
    blue = xmobarColor "#bd93f9" ""
    magenta = xmobarColor "#ff79c6" ""
    white = xmobarColor "#f8f8f2" ""
    yellow = xmobarColor "#f1fa8c" ""
    red = xmobarColor "#ff5555" ""
    lowWhite = xmobarColor "#888888" ""

myStartupHook :: X ()
myStartupHook = do
  spawnOnce "trayer --edge top --align right --SetDockType true \
             \--SetPartialStrut true --expand true --width 10 \
             \--transparent true --tint 0x5f5f5f --height 18"
  spawnOnce "xsetroot -cursor_name left_ptr"
  spawnOnce "feh --bg-fill --no-fehbg -z ~/.wallpapers"
  spawnOnce "nm-tray --sm-disable"
  spawnOnce "picom"
  spawnOnce "systemctl --user start docker-desktop"
  spawnOnce "xscreensaver --no-splash"

