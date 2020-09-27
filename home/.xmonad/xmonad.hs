import XMonad
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import XMonad.Util.Run(spawnPipe)
import XMonad.Util.EZConfig(additionalKeysP)
import Graphics.X11.Xlib.Cursor(xC_arrow)
import XMonad.Util.Cursor(setDefaultCursor)
import XMonad.Layout.NoBorders(smartBorders)
import XMonad.Actions.CycleRecentWS
import XMonad.Util.Paste(pasteString, sendKey)
import System.IO

import XMonad.Actions.WindowGo (runOrRaise)

{-For full screen Chromium-}
import XMonad.Hooks.EwmhDesktops

main = do
    xmproc <- spawnPipe "xmobar"

    xmonad $ defaultConfig
        { manageHook = manageDocks <+> manageHook defaultConfig
        , layoutHook = smartBorders $ avoidStruts  $  layoutHook defaultConfig
        , startupHook = myStartupHook
        , handleEventHook = fullscreenEventHook
        , logHook = dynamicLogWithPP xmobarPP
                        { ppOutput = hPutStrLn xmproc
                        , ppTitle = xmobarColor "green" "" . shorten 50
                        }
        , terminal = "lilyterm"
        } `additionalKeysP`
        [ ("M-S-z", spawn "slock")
        , ("S-<Print>", spawn "sleep 0.2; scrot -s -e 'mkdir -p ~/Pictures/scrots; mv $f ~/Pictures/scrots'")
        , ("<Print>", spawn "scrot -e 'mkdir -p ~/Pictures/scrots; mv $f ~/Pictures/scrots'")
        , ("M-<Tab>", cycleRecentWS [xK_Alt_L] xK_Tab xK_grave)
        , ("<XF86AudioMute>", spawn "ponymix toggle")
        , ("<XF86AudioLowerVolume>", spawn "ponymix decrease 5")
        , ("<XF86AudioRaiseVolume>", spawn "ponymix increase 5")
        , ("<XF86AudioMicMute>", spawn "pavucontrol")
        , ("<XF86MonBrightnessDown>", spawn "xbacklight -dec 2")
        , ("<XF86MonBrightnessUp>", spawn "xbacklight -inc 2")
        , ("<XF86Display>", spawn "sleep 0.2 && xset dpms force off")
        , ("M-m e", pasteString "jpeheffernan@gmail.com")
        , ("M-m j", do
                        sendKey noModMask xK_J
                        sendKey noModMask xK_H
          )
        ]

{-XF86WLAN-}
{-XF86Tools-}
{-XF86Search-}
{-XF86LaunchA-}
{-XF86Explorer-}

myStartupHook :: X ()
myStartupHook = do
    setDefaultCursor xC_arrow
    runOrRaise "chromium" (className =? "chromium")
    runOrRaise "stalonetray" (className =? "stalonetray")
    spawn "nm-applet"
    spawn "xxkb"
    spawn "feh --bg-fill ~/.wallpaper"
    spawn "setxkbmap -option ctrl:nocaps"
    spawn "clipit"
