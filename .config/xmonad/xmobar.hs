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
   , Run Cpu ["-t","<fc=#3c3836,#fbf1c7> <fn=1>\xf108</fn> cpu: (<total>%)  </fc>"] 20

-- CPU Core Temperature Indicator
   , Run MultiCoreTemp
   ["-t","<fc=#3c3836,#d8e49c> <fn=1></fn> <avg> °C  </fc>", "-L", "20", "-H", "80"] 30

-- RAM Usage Indicator
   , Run Memory ["-t","<fc=#3c3836,#fbf1c7> <fn=1></fn> <used>mb: (<usedratio>%)  </fc>"] 20

-- Network
   , Run DynNetwork ["-t","<fc=#3c3836,#d8e49c> <fn=1></fn> <tx>kB/s|<rx>kB/s  </fc>"
   , "--Low"      , "1000"       -- units: B/s
   , "--low"      , "#3c3836,#d8e49c"] 15

-- Weather Indicator
   , Run WeatherX "LGLR" [] ["-t","<fc=#3c3836,#fbf1c7> <fn=1></fn> <tempC> °C  </fc>"] 600

-- Free Available Disk Space
   , Run DiskU [("/","<fc=#3c3836,#d8e49c> <fn=1></fn> ssd: <free>  </fc>")] [] 600

-- Keyboard Layout Indicator
   , Run Kbd [("us", "<fc=#3c3836,#d8e49c> us  </fc>") , ("gr", "<fc=#3c3836,#d8e49c> ελ  </fc>")]

-- Battery information.
   , Run Battery ["--template" , "<fc=#3c3836,#fbf1c7><fn=1>  </fn><acstatus></fc>" , "--" 
   , "-o"	, "<fc=#3c3836,#fbf1c7><left>% (<timeleft>)  </fc>"
   , "-O"	, "<fc=#3c3836,#fbf1c7><left>%++  </fc>"] 100


-- Date/Time
   , Run Date "<fc=#3c3836,#fbf1c7> <fn=1></fn> %b %d %Y</fc><fc=#3c3836,#fbf1c7><fn=5></fn> %H:%M </fc>" "date" 50] 

-- Status Bar Template with custom powerline design (change VBox width depending on bar height)
   , template = 
   " <icon=haskell.xpm/> <fc=#666666>| </fc>%UnsafeStdinReader% }{\
   \<icon=pl3.xpm/><box type=Top width=6 mb=0 color=#fbf1c7><box type=Bottom width=8 mb=0 color=#fbf1c7>%cpu%</box></box>\
   \<icon=pl1.xpm/><box type=Top width=6 mb=0 color=#d8e49c><box type=Bottom width=8 mb=0 color=#d8e49c>%multicoretemp%</box></box>\
   \<icon=pl2.xpm/><box type=Top width=6 mb=0 color=#fbf1c7><box type=Bottom width=8 mb=0 color=#fbf1c7>%memory%</box></box>\
   \<icon=pl1.xpm/><box type=Top width=6 mb=0 color=#d8e49c><box type=Bottom width=8 mb=0 color=#d8e49c>%dynnetwork%</box></box>\
   \<icon=pl2.xpm/><box type=Top width=6 mb=0 color=#fbf1c7><box type=Bottom width=8 mb=0 color=#fbf1c7>%LGLR%</box></box>\
   \<icon=pl1.xpm/><box type=Top width=6 mb=0 color=#d8e49c><box type=Bottom width=8 mb=0 color=#d8e49c>%disku%</box></box>\
   \<icon=pl2.xpm/><box type=Top width=6 mb=0 color=#fbf1c7><box type=Bottom width=8 mb=0 color=#fbf1c7>%battery%</box></box>\
   \<icon=pl1.xpm/><box type=Top width=6 mb=0 color=#d8e49c><box type=Bottom width=8 mb=0 color=#d8e49c>%kbd%</box></box>\
   \<icon=pl2.xpm/><box type=Top width=6 mb=0 color=#fbf1c7><box type=Bottom width=8 mb=0 color=#fbf1c7>%date%</box></box>"