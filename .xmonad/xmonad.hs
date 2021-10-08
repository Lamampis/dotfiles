--                                               /\ \    
--   __  _   ___ ___     ___     ___      __     \_\ \   
--  /\ \/'\/' __` __`\  / __`\ /' _ `\  /'__`\   /'_` \  
--  \/>  <//\ \/\ \/\ \/\ \L\ \/\ \/\ \/\ \L\.\_/\ \L\ \ 
--   /\_/\_\ \_\ \_\ \_\ \____/\ \_\ \_\ \__/.\_\ \___,_\
--   \//\/_/\/_/\/_/\/_/\/___/  \/_/\/_/\/__/\/_/\/__,_ /                                        
-- Base.
import XMonad
import System.Directory
import System.IO
import System.Exit (exitSuccess)
import qualified XMonad.StackSet as W
-- Actions.
import XMonad.Actions.CopyWindow
import XMonad.Actions.MouseResize
import XMonad.Actions.Promote
import XMonad.Actions.RotSlaves
import XMonad.Actions.WithAll
-- Data.
import Data.Maybe 
import Data.Map as M
-- Hooks.
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.EwmhDesktops 
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.ManageHelpers
-- Layouts/Modifiers.
import XMonad.Layout.SimplestFloat
import XMonad.Layout.ResizableTile
import XMonad.Layout.LimitWindows
import XMonad.Layout.MultiToggle.Instances
import XMonad.Layout.NoBorders
import XMonad.Layout.Renamed
import XMonad.Layout.Spacing
import XMonad.Layout.ToggleLayouts as T
import XMonad.Layout.MultiToggle as MT
-- Utilities.
import XMonad.Util.EZConfig
import XMonad.Util.Run
import XMonad.Util.SpawnOnce
-- Defaults
myFont = "xft:Iosevka Nerd Font:regular:size=9:antialias=true:hinting=true"
myModMask = mod4Mask                             -- Sets Mod Key to Super/Win/Fn.
myTerminal = "alacritty"                         -- Sets default Terminal Emulator.
myBrowser = "brave"                              -- Sets default browser.
myBorderWidth = 2                                -- Sets Border Width in pixels.
myNormColor   = "#201c2c"                        -- Border color of normal windows.
myFocusColor  = "#BE7FFA"                        -- Border color of focused windows.
-- Startup Applications
myStartupHook = do
    spawnPipe "nitrogen --restore"   -- feh is the alternative "feh --bg-scale /directory/of/desired/background &"
    spawnPipe "picom --experimental-backends" --Compositor
    spawnOnce "/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1" -- Graphical authentication agent.
    spawnOnce "setxkbmap -model pc104 -layout us,gr -variant ,, -option grp:alt_shift_toggle" -- Switch keyboard layouts with Alt-Shift
    spawnOnce "xsetroot -cursor_name Left_ptr" 
    spawnOnce "unclutter"     -- Hides mouse when not in use.
    spawnOnce "xset s off"
    spawnOnce "xset s 0 0"
    spawnOnce "xset -dpms"
    spawnOnce "autorandr -cf" --  "xrandr --auto --output HDMI-2 --auto --left-of eDP-1"
-- Workspaces.
myWorkspaces = [" 1 ", " 2 ", " 3 ", " 4 ", " 5 ", " 6 ", " 7 ", " 8 ", " 9 "] 
myWorkspaceIndices = M.fromList $ zipWith (,) myWorkspaces [1..]
clickable ws = "<action=xdotool key super+"++show i++">"++ws++"</action>" -- i have no idea how this works
    where i = fromJust $ M.lookup ws myWorkspaceIndices
-- Layouts config.
tall     = renamed [Replace "Tall"]
           $ limitWindows 10
           $ spacingRaw False (Border 0 0 0 0) True (Border 10 10 10 10) True
           $ ResizableTall 1 (3/100) (10/20) []
monocle  = renamed [Replace "Monocle"]
           $ limitWindows 10 Full
floats   = renamed [Replace "Float"]
           $ limitWindows 10 simplestFloat
myLayoutHook = avoidStruts $ T.toggleLayouts floats $ lessBorders OnlyScreenFloat
             $ mkToggle (NBFULL ?? NOBORDERS ?? EOT) myDefaultLayout
             where  myDefaultLayout = (tall ||| smartBorders monocle ||| floats)
-- Keyboard shortcuts.
myKeys =
-- Base.
     [ ("M-S-r", spawn "xmonad --recompile")     -- Recomplies xmonad.
     , ("M-S-q", io exitSuccess)                 -- Quits xmonad.
     , ("M-S-c", kill1)                          -- Kill the currently focused client.
     , ("M-S-a", killAll)                        -- Kill all windows on current workspace.
     , ("M-S-n", spawn "rofi -show file-browser-extended -file-browser-show-hidden -theme RofiFiles") -- Launches rofi File Browser.
     , ("M-S-<Return>", spawn "rofi -show drun -theme RofiApplications") -- Launches rofi App Launcher.
     , ("M-S-<Right>", spawn "pamixer -i 10")    -- Increases Volume by 10%.
     , ("M-S-<Left>", spawn "pamixer -d 10")     -- Decreases Volume by 10%.
-- Spawn programs keybindings.
     , ("M-<Return>", spawn (myTerminal))        -- Launches Alacritty Terminal.
     , ("M-b", spawn (myBrowser))                -- Launches Brave Web Browser.
     , ("M-d", spawn "discord")                  -- Launches DiscordApp.
     , ("M-n", spawn "nemo")                     -- Launches Nemo file manager.
-- Window layouts modifiers.
     , ("M-f", sendMessage (T.Toggle "floats"))  -- Toggles my 'floats' layout.
     , ("M-t", withFocused $ windows . W.sink)   -- Push floating window back to tile.
     , ("M-S-t", sinkAll)                        -- Push ALL floating windows to tile.
     , ("M-<Space>", sendMessage (MT.Toggle NBFULL) >> sendMessage ToggleStruts) -- Toggles Fullscreen/NB.
     , ("M-<Tab>", sendMessage NextLayout)       -- Switch to next layout.
-- Space control.
     , ("M-S-i", decScreenSpacing 4)             -- Decrease screen spacing.
     , ("M-S-u", incScreenSpacing 4)             -- Increase screen spacing.
-- Resizing.
     , ("M-h", sendMessage Shrink)               -- Shrink horiz window width.
     , ("M-l", sendMessage Expand)               -- Expand horiz window width.
     , ("M-j", sendMessage MirrorShrink)         -- Shrink vert window width.
     , ("M-k", sendMessage MirrorExpand)         -- Expand vert window width.
-- Navigation.
     , ("M-m", windows W.focusMaster)            -- Move focus to the master window.
     , ("M-S-m", windows W.swapMaster)           -- Swap the focused window and the master window.
     , ("M-S-j", windows W.focusDown)            -- Move focus to the next window.
     , ("M-S-k", windows W.focusUp)              -- Move focus to the prev window.
     , ("M-S-h", windows W.swapDown)             -- Swap focused window with next window.
     , ("M-S-l", windows W.swapUp)               -- Swap focused window with prev window.
     , ("M-<Backspace>", promote)                -- Promote focused window to master.
     , ("M-S-<Tab>", rotSlavesDown)]             -- Rotate all windows except master and keep focus in place.
-- Set window properties.
myManageHook = composeAll                           
     [ className =? "control"         --> doFloat
     , className =? "error"           --> doFloat
     , className =? "file_progress"   --> doFloat
     , className =? "dialog"          --> doFloat
     , className =? "download"        --> doFloat
     , className =? "Gimp"            --> doFloat
     , className =? "Update"          --> doFloat
     , className =? "notification"    --> doFloat
     , className =? "pinentry-gtk-2"  --> doFloat
     , className =? "confirm"         --> doFloat
     , className =? "splash"          --> doFloat
     , className =? "toolbar"         --> doFloat
     , isFullscreen -->  doFullFloat ] 
-- Main.
main = do
    xmproc0 <- spawnPipe "xmobar -x 0 /home/lampis/.config/xmonad/xmobarrc1" 
    xmonad $ ewmh def 
     { manageHook         = myManageHook <+> manageDocks
     , handleEventHook    = docksEventHook <+> fullscreenEventHook     -- Auto Fullscreen. ((M-<Space>) to manually set fullscreen)
     , modMask            = myModMask
     , startupHook        = myStartupHook
     , layoutHook         = myLayoutHook
     , workspaces         = myWorkspaces
     , borderWidth        = myBorderWidth
     , normalBorderColor  = myNormColor
     , focusedBorderColor = myFocusColor 
     , logHook = dynamicLogWithPP $ xmobarPP                           -- Xmobar settings.
       { ppOutput = \x -> hPutStrLn xmproc0 x                          -- Places xmobar on Display 1.
       , ppCurrent = xmobarColor "#73d0ff" "" . wrap "<box type=Bottom width=2 mb=2 color=#c792ea>" "</box>"         -- Current Workspace.
       , ppVisible = xmobarColor "#73d0ff" "" . clickable              -- Visible Workspaces.
       , ppHidden = xmobarColor "#73d0ff" "" . wrap "<box type=Top width=2 mt=2 color=#82AAFF>" "</box>" . clickable -- Hidden Workspaces.
       , ppHiddenNoWindows = xmobarColor "#73d0ff" ""  . clickable     -- Hidden Workspaces without windows.
       , ppTitle = xmobarColor "#b3afc2" "" . shorten 60               -- Active window title.
       , ppSep =  "<fc=#666666> <fn=1>|</fn> </fc>"                    -- Separator character.
       , ppLayout = xmobarColor "#67bbe5" ""                           -- Current Layout Indicator.
       , ppUrgent = xmobarColor "#C45500" "" . wrap "!" "!"            -- Urgent workspace.
       , ppOrder  = \(ws:l:t:ex) -> [ws,l]++ex++[t] } }                -- Xmobar template.
       `additionalKeysP` myKeys
