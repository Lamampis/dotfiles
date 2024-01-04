--  https://github.com/Lamampis                  /\ \    
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
import XMonad.Hooks.WindowSwallowing
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
myFont = "xft:Iosevka:regular:size=9:antialias=true:hinting=true"
myModMask = mod4Mask                             -- Sets Mod Key to Super/Win/Fn.
myTerminal = "kitty"                         -- Sets default Terminal Emulator.
myBrowser = "firefox-bin"                        -- Sets default browser.
myFileManager = "nemo"                        -- Sets default file manager.
myBorderWidth = 2                                -- Sets Border Width in pixels.
myNormColor   = "#282828"                        -- Border color of unfocused windows.
myFocusColor  = "#d8e49c"                        -- Border color of focused windows.
-- Startup Applications (the rest are on my .xinitrc)
myStartupHook = do
    spawnPipe "picom --vsync"
    spawnOnce "unclutter"
-- Workspaces.
myWorkspaces = [" 1 ", " 2 ", " 3 ", " 4 ", " 5 ", " 6 ", " 7 ", " 8 ", " 9 "] 
myWorkspaceIndices = M.fromList $ zipWith (,) myWorkspaces [1..]
clickable ws = "<action=xdotool key super+"++show i++">"++ws++"</action>" -- i have no idea how this works
    where i = fromJust $ M.lookup ws myWorkspaceIndices
-- Layouts config.
tall = renamed [Replace "Tall"]
           $ limitWindows 6
           $ spacingRaw False (Border 0 0 0 0) True (Border 10 10 10 10) True
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
     [ ("M-S-r", spawn "xmonad --recompile")     -- Recompiles xmonad.
     , ("M-q", spawn "xmonad --restart")         -- Restarts xmonad.
     , ("M-S-q", io exitSuccess)                 -- Quits xmonad.
     , ("M-S-c", kill1)                          -- Kill the currently focused client.
     , ("M-S-a", killAll)                        -- Kill all windows on current workspace.
-- Spawn programs keybindings.
     , ("M-<Return>", spawn (myTerminal))        -- Launches Default Terminal.
     , ("M-b", spawn (myBrowser))                -- Launches Default Browser.
     , ("M-n", spawn (myFileManager))            -- Launches Default file manager.
     , ("M-d", spawn "ELECTRON_ENABLE_STACK_DUMPING=true discord")
     , ("M-S-s", spawn "maim -s ~/Pictures/$(date +%s).png") --Uses maim to take a screenshot of the selected area.
     , ("M-S-<Right>", spawn "pulseaudio-ctl up")    -- Increases Volume by 10%.
     , ("M-S-<Left>", spawn "pulseaudio-ctl down")   -- Decreases Volume by 10%.
     ,("M-S-<Return>", spawn "rofi -show drun -theme RofiApplications") -- Launches rofi App Launcher.
-- Window layouts modifiers.
     , ("M-t", withFocused $ windows . W.sink)   -- Push floating window back to tile.
     , ("M-S-t", sinkAll)                        -- Push ALL floating windows to tile.
     , ("M-<Space>", sendMessage (MT.Toggle NBFULL) >> sendMessage ToggleStruts) -- Toggles Fullscreen/No Borders.
     , ("M-<Tab>", sendMessage NextLayout)       -- Switch to next layout.
-- Resizing.
     , ("M-S-i", decScreenSpacing 8)             -- Increase screen spacing.
     , ("M-S-u", incScreenSpacing 8)             -- Decrease screen spacing.
     , ("M-S-h", sendMessage Shrink)             -- Shrink horiz window width.
     , ("M-S-j", sendMessage MirrorShrink)       -- Shrink vert window width.
     , ("M-S-k", sendMessage MirrorExpand)       -- Expand vert window width.
     , ("M-S-l", sendMessage Expand)             -- Expand horiz window width.
-- Navigation.
     , ("M-m", windows W.focusMaster)            -- Move focus to the master window.
     , ("M-S-m", windows W.swapMaster)           -- Swap the focused window and the master window.
     , ("M-h", windows W.focusUp)                -- Move focus to prev window.
     , ("M-j", windows W.swapUp)               -- Swap focused windows with next window.
     , ("M-k", windows W.swapDown)                 -- Swap focused window with prev window.
     , ("M-l", windows W.focusDown)              -- Move focus to next window.
     , ("M-<Backspace>", promote)                -- Promote focused window to master.
     , ("M-S-<Backspace>", rotSlavesDown)]       -- Rotate all windows except master and keep focus in place.
-- Set window properties.
myManageHook = composeAll                           
     [ className =? "control"         --> doFloat
     , className =? "error"           --> doFloat
     , className =? "file_progress"   --> doFloat
     , className =? "dialog"          --> doFloat
     , className =? "download"        --> doFloat
     , className =? "Update"          --> doFloat
     , className =? "notification"    --> doFloat
     , className =? "pinentry-gtk-2"  --> doFloat
     , className =? "confirm"         --> doFloat
     , className =? "splash"          --> doFloat
     , className =? "toolbar"         --> doFloat
     , isFullscreen -->  doFullFloat ] 
-- Main.
main = do
    xmproc0 <- spawnPipe "xmobar -x 0 ~/.config/xmonad/xmobar.hs"
    xmonad . docks . ewmh . ewmhFullscreen $ def
     { manageHook         = myManageHook
     , handleEventHook    = swallowEventHook (className =? myTerminal) (return True)
     , modMask            = myModMask
     , startupHook        = myStartupHook
     , layoutHook         = myLayoutHook
     , workspaces         = myWorkspaces
     , borderWidth        = myBorderWidth
     , normalBorderColor  = myNormColor
     , focusedBorderColor = myFocusColor 
     , logHook = dynamicLogWithPP $ xmobarPP                           -- Xmobar settings.
       { ppOutput = \x -> hPutStrLn xmproc0 x                          -- Places xmobar on Display 1.
       , ppCurrent = xmobarColor "#ebdbb2" "" . wrap "<box type=Bottom width=2 mb=2 color=#ebdbb2>" "</box>"         -- Current Workspace.
       , ppVisible = xmobarColor "#ebdbb2" "" . clickable              -- Visible Workspaces.
       , ppHidden = xmobarColor "#ebdbb2" "" . wrap "<box type=Top width=2 mt=2 color=#ebdbb2>" "</box>" . clickable -- Hidden Workspaces.
       , ppHiddenNoWindows = xmobarColor "#ebdbb2" ""  . clickable     -- Hidden Workspaces without windows.
       , ppTitle = xmobarColor "#ebdbb2" "" . shorten 60               -- Active window title.
       , ppSep =  "<fc=#666666> <fn=0>|</fn> </fc>"                    -- Separator character.
       , ppLayout = xmobarColor "#ebdbb2" ""                           -- Current Layout Indicator.
       , ppUrgent = xmobarColor "#ebdbb2" "" . wrap "!" "!"            -- Urgent workspace.
       , ppOrder  = \(ws:l:t:ex) -> [ws,l]++ex++[t] } }                -- Xmobar template.
       `additionalKeysP` myKeys
