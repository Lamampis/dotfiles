--                          /\ \                       
--   __  _   ___ ___     ___\ \ \____     __     _ __  
--  /\ \/'\/' __` __`\  / __`\ \ '__`\  /'__`\  /\`'__\
--  \/>  <//\ \/\ \/\ \/\ \L\ \ \ \L\ \/\ \L\.\_\ \ \/ 
--   /\_/\_\ \_\ \_\ \_\ \____/\ \_,__/\ \__/.\_\\ \_\ 
--   \//\/_/\/_/\/_/\/_/\/___/  \/___/  \/__/\/_/ \/_/                                               
--   
-- Fonts
   Config { font    = "Iosevka Term 9"
   , additionalFonts = [ "Font Awesome 6 Free Solid 8"]

-- Parameters
   , bgColor = "#282828"
   , fgColor = "#3c3836"
   , position = TopSize C 100 26 --Max Bar size is 31 in order for the powerline effect to work
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
   , Run Cpu ["-t"," <fn=1>\xf108</fn> cpu: (<total>%)  "] 20

-- CPU Core Temperature Indicator
   , Run MultiCoreTemp
   ["-t"," <fn=1></fn> <avg> °C  ", "-L", "20", "-H", "80"] 30

-- RAM Usage Indicator
   , Run Memory ["-t"," <fn=1></fn> <used>mb: (<usedratio>%)  "] 20

-- Network
   , Run DynNetwork ["-t"," <fn=1></fn> <rx>.0kB/s  "] 15

-- Weather Indicator
   , Run WeatherX "LGLR" [] ["-t"," <fn=1></fn> <tempC> °C  "] 600

-- Free Available Disk Space
   , Run DiskU [("/"," <fn=1></fn> ssd: <free>  ")] [] 600

-- Keyboard Layout Indicator
   , Run Kbd [("us", " us  ") , ("gr", " ελ  ")]

-- Battery information.
   , Run Battery ["--template" , "<fc=#3c3836,#fbf1c7><fn=1>  </fn><acstatus></fc>" , "--" 
   , "-o"	, "<left>% | (<timeleft>) "
   , "-i"	, "<left>% | Full  "
   , "-O"	, "<left>%+ | (<timeleft>) "] 50

-- Date/Time
   , Run Date "<fn=1></fn> %b %d %Y<fn=5></fn> %H:%M " "date" 50] 

-- Status Bar Template with custom powerline design (change VBox width depending on bar height)
   , template = 
   " <icon=haskell.xpm/> <fc=#666666>| </fc>%UnsafeStdinReader% }{\
   \<fc=#3c3836,#fbf1c7><icon=pl3.xpm/><box type=Top width=6 mb=0 color=#fbf1c7><box type=Bottom width=8 mb=0 color=#fbf1c7>%cpu%</box></box></fc>\
   \<fc=#3c3836,#d8e49c><icon=pl1.xpm/><box type=Top width=6 mb=0 color=#d8e49c><box type=Bottom width=8 mb=0 color=#d8e49c>%multicoretemp%</box></box></fc>\
   \<fc=#3c3836,#fbf1c7><icon=pl2.xpm/><box type=Top width=6 mb=0 color=#fbf1c7><box type=Bottom width=8 mb=0 color=#fbf1c7>%memory%</box></box></fc>\
   \<fc=#3c3836,#d8e49c><icon=pl1.xpm/><box type=Top width=6 mb=0 color=#d8e49c><box type=Bottom width=8 mb=0 color=#d8e49c>%dynnetwork%</box></box></fc>\
   \<fc=#3c3836,#fbf1c7><icon=pl2.xpm/><box type=Top width=6 mb=0 color=#fbf1c7><box type=Bottom width=8 mb=0 color=#fbf1c7>%LGLR%</box></box></fc>\
   \<fc=#3c3836,#d8e49c><icon=pl1.xpm/><box type=Top width=6 mb=0 color=#d8e49c><box type=Bottom width=8 mb=0 color=#d8e49c>%disku%</box></box></fc>\
   \<fc=#3c3836,#fbf1c7><icon=pl2.xpm/><box type=Top width=6 mb=0 color=#fbf1c7><box type=Bottom width=8 mb=0 color=#fbf1c7>%battery%</box></box></fc>\
   \<fc=#3c3836,#d8e49c><icon=pl1.xpm/><box type=Top width=6 mb=0 color=#d8e49c><box type=Bottom width=8 mb=0 color=#d8e49c>%kbd%</box></box></fc>\
   \<fc=#3c3836,#fbf1c7><icon=pl2.xpm/><box type=Top width=6 mb=0 color=#fbf1c7><box type=Bottom width=8 mb=0 color=#fbf1c7>%date%</box></box></fc>"
