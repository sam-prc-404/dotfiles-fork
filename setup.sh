#! /bin/bash
# The install script

success_status=0
# Checks if yay exists
which yay >/dev/null 2>&1
if [[ $? -ne $success_status ]]; then
  # Installs yay if it doesn't exist
  git clone --depth 1 https://aur.archlinux.org/yay-bin.git
  cd yay-bin/
  makepkg -si
  cd ../
  rm -rf yay-bin
fi

yay -Y --devel --combinedupgrade --batchinstall --save
yay -Syu --noconfirm

# Checks if swaylock exists
which swaylock >/dev/null 2>&1
if [[ $? -eq $success_status ]]; then
  # Removes it to install swaylock-effects if it exists
  yay -R --noconfirm swaylock
fi

# Checks if waybar exists
which waybar >/dev/null 2>&1
if [[ $? -eq $success_status ]]; then
  # Removes it to install waybar-hyprland-git if it exists
  yay -R --noconfirm waybar
fi

# All the apps
yay -S --noconfirm hicolor-icon-theme hyprland xdg-desktop-portal-hyprland kitty dunst noto-fonts \
polkit-kde-agent waybar-hyprland-git udiskie bat brightnessctl wl-clipboard ffmpeg man-pages man-db \
candy-icons-git dust exa fd fish fzf github-cli gitui helix hyperfine noto-fonts-emoji zoxide evince \
ripgrep rofi-emoji starship swaylock-effects tealdeer thunar thunar-archive-plugin imagemagick \
ttf-jetbrains-mono-nerd vlc xdg-user-dirs sddm keepassxc gvfs librewolf-bin gnu-free-fonts \
grim grimblast-git ffmpegthumbnailer bluez-utils blueman bluez wlogout wl-clip-persist-git \
nwg-look-bin file-roller kvantum network-manager-applet htop sddm-sugar-candy-git pavucontrol \
tumbler rofi-calc eog gvfs-mtp noto-fonts-cjk pamixer otf-font-awesome prettier swaybg \

cp .bash_profile ~/
cp -r Pictures ~/
cp -r .config/* ~/.config/
sudo cp sddm.conf /etc/sddm.conf

# Rust
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh

xdg-user-dirs-update 
sudo systemctl enable sddm.service
sudo systemctl enable bluetooth.service
sudo ln -s /usr/bin/helix /usr/bin/hx
sudo ln -s /usr/bin/rofi /usr/bin/dmenu
bat cache --build
tldr -u

