--                          /\ \                       
--   __  _   ___ ___     ___\ \ \____     __     _ __  
--  /\ \/'\/' __` __`\  / __`\ \ '__`\  /'__`\  /\`'__\
--  \/>  <//\ \/\ \/\ \/\ \L\ \ \ \L\ \/\ \L\.\_\ \ \/ 
--   /\_/\_\ \_\ \_\ \_\ \____/\ \_,__/\ \__/.\_\\ \_\ 
--   \//\/_/\/_/\/_/\/_/\/___/  \/___/  \/__/\/_/ \/_/                                               
--   
-- Fonts
   Config { font    = "Iosevka Medium 8"}

-- Parameters
   , bgColor = "#262626"
   , fgColor = "#3c3836"
   , position = TopSize C 100 24 --Max Bar size is 31 in order for the powerline effect to work
   , lowerOnStart = False
   , allDesktops = True
   , sepChar = "%"
   , alignSep = "}{"
   , persistent = True
   , iconRoot = "/home/lampis/.config/xmonad/xpm/"
   , commands = [

-- Workspaces Indicator (see xmonad.hs)
   Run UnsafeStdinReader

-- Cpu Usage 
   , Run Cpu ["-t"," <fn=1>\xf108</fn> cpu: (<total>%)  "] 60

-- RAM Usage Indicator
   , Run Memory ["-t"," <fn=1></fn> <used>mb: (<usedratio>%)  "] 30

-- Network
   , Run DynNetwork ["-t"," <fn=1></fn> <rx>.0kB/s  "] 20

-- Weather Indicator
   , Run WeatherX "LGLR" [] ["-t"," <fn=1></fn> <tempC> °C  "] 1200

-- Free Available Disk Space
   , Run DiskU [("/"," <fn=1></fn> ssd: <free>  ")] [] 1800

-- Keyboard Layout Indicator
   , Run Kbd [("us", " us  ") , ("gr", " ελ  ")]

-- Battery information.
   , Run Battery ["--template" , "<fn=1>  </fn><acstatus>" , "--" 
   , "-o"	, "<left>%  "
   , "-i"	, "<left>%  "
   , "-O"	, "<left>%+  "] 30

-- Date/Time
   , Run Date "<fn=1></fn> %b %d %Y<fn=5></fn> %H:%M " "date" 50] 

-- Status Bar Template with custom powerline design (change VBox width depending on bar height)
   , template = 
   " <icon=haskell.xpm/> <fc=#666666>| </fc>%UnsafeStdinReader% }{\
   \<fc=#3c3836,#fbf1c7><icon=pl3.xpm/><box type=Top width=6 mb=0 color=#fbf1c7><box type=Bottom width=8 mb=0 color=#fbf1c7>%cpu%</box></box></fc>\
   \<fc=#3c3836,#d8e49c><icon=pl1.xpm/><box type=Top width=6 mb=0 color=#d8e49c><box type=Bottom width=8 mb=0 color=#d8e49c>%memory%</box></box></fc>\
   \<fc=#3c3836,#fbf1c7><icon=pl2.xpm/><box type=Top width=6 mb=0 color=#fbf1c7><box type=Bottom width=8 mb=0 color=#fbf1c7>%dynnetwork%</box></box></fc>\
   \<fc=#3c3836,#d8e49c><icon=pl1.xpm/><box type=Top width=6 mb=0 color=#d8e49c><box type=Bottom width=8 mb=0 color=#d8e49c>%LGLR%</box></box></fc>\
   \<fc=#3c3836,#fbf1c7><icon=pl2.xpm/><box type=Top width=6 mb=0 color=#fbf1c7><box type=Bottom width=8 mb=0 color=#fbf1c7>%disku%</box></box></fc>\
   \<fc=#3c3836,#d8e49c><icon=pl1.xpm/><box type=Top width=6 mb=0 color=#d8e49c><box type=Bottom width=8 mb=0 color=#d8e49c>%battery%</box></box></fc>\
   \<fc=#3c3836,#fbf1c7><icon=pl2.xpm/><box type=Top width=6 mb=0 color=#fbf1c7><box type=Bottom width=8 mb=0 color=#fbf1c7>%kbd%</box></box></fc>\
   \<fc=#3c3836,#d8e49c><icon=pl1.xpm/><box type=Top width=6 mb=0 color=#d8e49c><box type=Bottom width=8 mb=0 color=#d8e49c>%date%</box></box></fc>"
