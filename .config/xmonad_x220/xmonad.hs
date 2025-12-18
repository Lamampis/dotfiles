-- https://github.com/Lamampis               /\ \  
--  __  _   ___ ___         ___       ___       \_\ \  
--  /\ \/'\/' __` __`\  / __`\ /' _ `\  /'__`\  /'_` \ 
--  \/>  <//\ \/\ \/\ \/\ \L\ \/\ \/\ \/\ \L\.\_/\ \L\ \ 
--  /\_/\_\ \_\ \_\ \_\ \____/\ \_\ \_\ \__/.\_\ \___,_\
--  \//\/_/\/_/\/_/\/_/\/___/  \/_/\/_/\/__/\/_/\/__,_ /            
-- Base.
import XMonad
import System.Directory
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
import XMonad.Hooks.EwmhDesktops 
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.ManageHelpers
import XMonad.Hooks.WindowSwallowing
import XMonad.Hooks.InsertPosition
-- Layouts/Modifiers.
import XMonad.Layout.SimplestFloat
import XMonad.Layout.ResizableTile
import XMonad.Layout.LimitWindows
import XMonad.Layout.NoBorders
import XMonad.Layout.MultiToggle.Instances
import XMonad.Layout.Renamed
import XMonad.Layout.Spacing
import XMonad.Layout.ToggleLayouts as T
import XMonad.Layout.MultiToggle as MT
-- Utilities.
import XMonad.Util.EZConfig
import XMonad.Util.Run
import XMonad.Util.SpawnOnce
-- Defaults
myFont = "xft:Iosevka:regular:size=10:antialias=true:hinting=true"
myModMask = mod4Mask                          -- Sets Mod Key to Super/Win/Fn.
myTerminal = "st"                      -- Sets default Terminal Emulator.
myBrowser = "zen"                             -- Sets default browser.
myFileManager = "nemo"                        -- Sets default file manager.
myBorderWidth = 2                             -- Sets Border Width in pixels.
myNormColor   = "#303338"                     -- Border color of unfocused windows.
myFocusColor  = "#ff0000"                     -- Border color of focused windows.
-- Startup Applications (the rest are on my .xinitrc)
myStartupHook = do
    spawnOnce "polybar"
    spawnOnce "picom --vsync --backend glx"
-- Workspaces.
myWorkspaces = [" 1 ", " 2 ", " 3 ", " 4 ", " 5 ", " 6 ", " 7 ", " 8 ", " 9 "] 
myWorkspaceIndices = M.fromList $ zipWith (,) myWorkspaces [1..]
-- Layouts config.
tall = renamed [Replace "Tall"]
            $ limitWindows 6
            $ spacingRaw False (Border 0 0 0 0) True (Border 0 0 0 0) True
            $ ResizableTall 1 (3/100) (10/20) []
monocle  = renamed [Replace "Monocle"]
            $ limitWindows 10 Full
floats   = renamed [Replace "Float"]
            $ limitWindows 10 simplestFloat
myLayoutHook = avoidStruts $ T.toggleLayouts floats $ lessBorders OnlyScreenFloat
              $ mkToggle (NBFULL ?? NOBORDERS ?? EOT) myDefaultLayout
              where  myDefaultLayout = (tall ||| smartBorders monocle ||| floats)
-- Keybindigs.
myKeys =
-- Base.
      [ ("M-S-r", spawn "xmonad --recompile")      -- Recompiles xmonad.
      , ("M-q", spawn "xmonad --restart")          -- Restarts xmonad.
      , ("M-S-q", spawn "killall xmonad-x86_64-linux")                  -- Quits xmonad.
      , ("M-S-x", kill1)                           -- Kill the currently focused client.
      , ("M-S-a", killAll)                         -- Kill all windows on current workspace.
-- Spawn programs keybindings.
      , ("M-<Return>", spawn (myTerminal))         -- Launches Default Terminal.
      , ("M-b", spawn (myBrowser))                 -- Launches Default Browser.
      , ("M-n", spawn (myFileManager))             -- Launches Default file manager.
      , ("<XF86AudioRaiseVolume>", spawn "pactl set-sink-volume @DEFAULT_SINK@ +5%")    
      , ("<XF86AudioLowerVolume>", spawn "pactl set-sink-volume @DEFAULT_SINK@ -5%")
      , ("<XF86AudioMute>", spawn "pactl set-sink-mute @DEFAULT_SINK@ toggle")    --Mute/Unmute Volume.
      , ("<XF86AudioMicMute>", spawn "pactl set-source-mute @DEFAULT_SOURCE@ toggle")    --Mute/Unmute Mic.
      , ("<XF86MonBrightnessDown>", spawn "brightnessctl set 5%-")     --Mute/Unmute Volume.
      , ("<XF86MonBrightnessUp>", spawn "brightnessctl set 5%+")       --Mute/Unmute Mic.
      , ("<Print>", spawn "maim -s | tee $HOME/Pictures/Screenshots/Screenshot-$(date +%Y-%m-%d-%H:%M:%S).png | xclip -selection clipboard -t image/png")    --Screenshot
      , ("M-S-<Return>", spawn "rofi -show drun") -- Launches rofi App Launcher.
-- Window layouts modifiers.
      , ("M-t", withFocused $ windows . W.sink)    -- Push floating window back to tile.
      , ("M-S-t", sinkAll)                         -- Push ALL floating windows to tile.
      , ("M-<Space>", sendMessage (MT.Toggle NBFULL) >> sendMessage ToggleStruts) -- Toggles Fullscreen/No Borders.
      , ("M-<Tab>", sendMessage NextLayout)        -- Switch to next layout.
-- Resizing.
      , ("M-S-i", decScreenSpacing 8)              -- Increase screen spacing.
      , ("M-S-u", incScreenSpacing 8)              -- Decrease screen spacing.
      , ("M-S-h", sendMessage Shrink)              -- Shrink horiz window width.
      , ("M-S-j", sendMessage MirrorShrink)        -- Shrink vert window width.
      , ("M-S-k", sendMessage MirrorExpand)        -- Expand vert window width.
      , ("M-S-l", sendMessage Expand)              -- Expand horiz window width.
-- Navigation.
      , ("M-m", windows W.focusMaster)             -- Move focus to the master window.
      , ("M-S-m", windows W.swapMaster)            -- Swap the focused window and the master window.
      , ("M-h", windows W.focusUp)                 -- Move focus to prev window.
      , ("M-j", windows W.swapUp)                  -- Swap focused windows with next window.
      , ("M-k", windows W.swapDown)                -- Swap focused window with prev window.
      , ("M-l", windows W.focusDown)               -- Move focus to next window.
      , ("M-<Backspace>", promote)                 -- Promote focused window to master.
      , ("M-S-<Backspace>", rotSlavesDown)]        -- Rotate all windows except master and keep focus in place.
-- Set window properties.
myManageHook = composeAll                            
      [ className =? "control"          --> doFloat
      , className =? "error"            --> doFloat
      , className =? "file_progress"    --> doFloat
      , className =? "dialog"           --> doFloat
      , className =? "download"         --> doFloat
      , className =? "Update"           --> doFloat
      , className =? "notification"     --> doFloat
      , className =? "pinentry-gtk-2"   --> doFloat
      , className =? "confirm"          --> doFloat
      , className =? "splash"           --> doFloat
      , className =? "toolbar"          --> doFloat
      , isFullscreen -->  doFullFloat ] 
-- Main.
main = do
    -- Removed spawnPipe line
    xmonad . docks . ewmh . ewmhFullscreen $ def
      { manageHook           = insertPosition Below Newer <+> myManageHook
      , handleEventHook      = swallowEventHook (className =? myTerminal) (return True)
      , modMask              = myModMask
      , startupHook          = myStartupHook
      , layoutHook           = myLayoutHook
      , workspaces           = myWorkspaces
      , borderWidth          = myBorderWidth
      , normalBorderColor    = myNormColor
      , focusedBorderColor   = myFocusColor 
      -- Removed logHook section entirely
      } `additionalKeysP` myKeys
