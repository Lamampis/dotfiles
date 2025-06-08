# My XMonad and Hyprland configuration
My dotfiles for my XMonad & Hyprland. This repo is mostly meant for me to store my configs for easy access but feel free to yoink them. 
I recently switched over to hyprland, it's a great window manager. My configs for both window managers are very similar. I only use hyprland nowadays, 
but my old configs for xmonad will still be available here.

I try to keep my files easily readable and editable. Waybar has defined colors for easy theme switching. Keep in mind that my Hyprland ecosystem is configured for a low res 1366x768 display, so remember to adjust the config files accoring to your screen resolution. 

### Prerequisites: 

 Xmonad, xmonad-contrib and xmobar from the Arch repos are old and the git versions from the AUR seem to cause problems.
I recommend installing these packages with stack, [here's how.](https://brianbuccola.com/how-to-install-xmonad-and-xmobar-via-stack/)

On Gentoo Linux, compile xmobar with the `xpm` and `xft` USE flags.

## Kernel
 I use a custom kernel for my Thinkpad X230 Gentoo installation, it uses LZ4 to compress the kernel and the initramfs. For me, I have to add the line `compress="lz4"` to the file `/etc/dracut.conf.d/myflags.conf` and compile `sys-kernel/installkernel` with the `dracut` USE flag. It might slightly improve battery life over the dist-kernel.

### Screenshots

## XMonad (On workstation laptop)

![](Images/desktopscreenshot.png)

![](Images/1678902994.png)

![](Images/1678903064.png)

## Hyprland (on my X230 Thinkpad)

![](Images/Screenshot-2024-12-30_20:39:47.png)

![](Images/image.png)

### OS: 
Gentoo Linux

### Window Manager: 
xmonad, hyprland

### Bar: 
xmobar, waybar

### Search Prompt: 
tofi

### Font: 
Iosevka, Terminus

### Colorscheme: 
[Gruvbox Dark](https://github.com/jmattheis/gruvbox-dark-gtk)
Mint-Y-Red (from Linux Mint)

### Icons: 
Mint-L Legacy, Haiku

### Terminal: 
foot

### Shell: 
yash

### Editor:
Neovim (NVChad), mousepad

### Compositor: 
picom

### Wallpaper applier: 
feh, waypaper/swww

### Notifications: 
Dunst

### Misc software that I use:
mpv, maim, MuPDF, nemo, wf-recorder, grim+slurp, Obsidian, LibreOffice, tlp, doas, imv

### Contact Info:
Do message me if you have any questions/request regarding my dotfiles.

Discord: lamampis
Mail: lampis750@tutanota.com
