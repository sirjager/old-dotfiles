
#!/usr/bin/sh

# This is only for arch linux

# Colored prints function
_clr() {
    case "$1" in
    "red")
        printf "\033[1;31m$2\033[0m\n"
        ;;
    "green")
        printf "\033[1;32m$2\033[0m\n"
        ;;
    "yellow")
        printf "\033[1;33m$2\033[0m\n"
        ;;
    "orange")
        printf "\033[1;34m$2\033[0m\n"
        ;;
    "purple")
        printf "\033[1;35m$2\033[0m\n"
        ;;
    "cyan")
        printf "\033[1;36m$2\033[0m\n"
        ;;
    "gray" | "grey")
        printf "\033[1;37m$2\033[0m\n"
        ;;
    "white")
        printf "\033[1;37m$2\033[0m\n"
        ;;
    *)
        printf "$2\n"
        ;;
    esac
}

update_system() {
    echo " "
    _clr cyan "Updating system"
    echo " "
    sudo pacman -Syyu
}

install_yay() {
    echo " "
    _clr cyan "Installing pacakge manager: yay"
    echo " "
    sudo pacman --noconfirm -S yay &&
        _clr green "Successfully installed: yay" ||
        _clr red "Failed to install package manager: yay"
}

# These packages will always be installed.
install_core_pkgs() {
    echo " "
    _clr cyan "Installing core packages"
    echo " "
    yay --needed --noconfirm -S \
        timeshift timeshift-autosnap libconfig pkgconfig \
        wget htop curl git gufw xclip xorg-xinput xorg-xsetroot xsel \
        exa light network-manager-applet appimagelauncher \
        sddm qt5-graphicaleffects qt5-quickcontrols2 qt5-svg \
        neovim emacs neofetch tmux zsh fzf lazygit alacritty kitty \
        fcitx-anthy fcitx-configtool fcitx-im fcitx-mozc \
        adobe-source-han-sans-jp-fonts adobe-source-han-serif-jp-fonts \
        mpv kdeconnect scrcpy
}

mount_ntfs_storage() {
    echo " "
    TARGET_NTFS_STORAGE_NAME="STORAGE"
    MOUNT_TARGETED_NTFS_AT_THIS_PATH=/mnt/storage
    NTFS_DRIVE_UUID=$(sudo blkid -s UUID -o value -l -c /dev/null -t LABEL="$TARGET_NTFS_STORAGE_NAME")
    if [ -n "$NTFS_DRIVE_UUID" ]; then
        # Append the entry to /etc/fstab using the stored UUID
        sudo mkdir -p $MOUNT_TARGETED_NTFS_AT_THIS_PATH
        echo "UUID=$NTFS_DRIVE_UUID $MOUNT_TARGETED_NTFS_AT_THIS_PATH ntfs defaults 0 1" | sudo tee -a /etc/fstab
        sudo systemctl daemon-reload
        sudo mount -a
        _clr green "Successfully mounted $TARGET_NTFS_STORAGE_NAME ($NTFS_DRIVE_UUID) at path $MOUNT_TARGETED_NTFS_AT_THIS_PATH"
    else
        _clr red "Error: Unable to retrieve the UUID for the '$TARGET_NTFS_STORAGE_NAME' partition."
    fi
}

setup_sddm() {
    echo " "
    _clr cyan "Installing SDDM and required dependencies"
    echo " "
    yay --needed --noconfirm -S sddm qt5-graphicaleffects qt5-quickcontrols2 qt5-svg
    if [ $? -eq 0 ]; then
        _clr green "Successfully installed SDDM"
    else
        _clr red "Failed to install SDDM"
        return 1
    fi

    sudo systemctl disable lightdm
    sudo systemctl disable gdm

    _clr purple "Enabling sddm service..."
    sudo systemctl enable sddm

    rm -rf ~/Downloads/sugar-candy

    _clr purple "Downloading sddm theme sugar-candy..."
    git clone https://github.com/Kangie/sddm-sugar-candy ~/Downloads/sugar-candy
    sudo rm -rf /usr/share/sddm/themes/sugar-candy
    sudo mv ~/Downloads/sugar-candy /usr/share/sddm/themes/sugar-candy
    sudo rm -f /etc/sddm.conf
    sudo cp -f /usr/lib/sddm/sddm.conf.d/default.conf /etc/sddm.conf
    sudo echo 'Background="/mnt/storage/wallpaper/sddm.png"' >>/usr/share/sddm/themes/sugar-candy/theme.conf
    sudo echo 'PartialBlur="false"' >>/usr/share/sddm/themes/sugar-candy/theme.conf
    if [ $? -eq 0 ]; then
        _clr green "Successfully installed sddm theme sugar-candy"
        _clr purple "NOTE: set Current=sugar-candy under [THEME] in /etc/sddm.conf"
    else
        _clr red "Failed to install sddm theme sugar-candy"
        return 1
    fi
}

setup_firewall() {
    echo " "
    _clr cyan "Installing firewall: gufw"
    echo " "
    yay --noconfirm -Rns firewalld
    yay --needed --noconfirm -S gufw
    if [ $? -eq 0 ]; then
        _clr green "Successfully installed firewall: gufw"
    else
        _clr red "Failed to install firewall: gufw"
        return 1
    fi
    sudo systemctl enable --now ufw
    _clr green "Firewall is now active"
}

setup_tmux() {
    echo " "
    _clr cyan "Installing TMUX"
    echo " "
    yay --needed --noconfirm -S tmux
    if [ $? -eq 0 ]; then
        _clr green "Successfully installed TMUX"
    else
        _clr red "Failed to install TMUX"
        return 1
    fi

    _clr purple "Setting up Tmuxifier..."
    rm -rf ~/.tmuxifier
    git clone https://github.com/jimeh/tmuxifier.git ~/.tmuxifier

    # Tmux Plugin Manager
    _clr purple "Setting up TPM (Tmux Plugin Manager)"
    rm -rf ~/.tmux/plugins/tpm
    git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

    _clr green "Tmux successfully installed and configured"
    _clr purple "NOTE: Sync tmp packages by pressing: CTRL+SPACE   I"
}

setup_dotfiles_repo() {
    GITHUB_BARE_REPO="git@github.com:sirjager/.dots"
    echo " "
    _clr cyan "Setting up dotfiles bare repository"
    echo " "

    rm -rf ~/.dots
    _clr purple "Cloning github repository $GITHUB_BARE_REPO ..."
    git clone --bare $GITHUB_BARE_REPO ~/.dots

    alias dots='/usr/bin/git --git-dir=$HOME/.dots --work-tree=$HOME'
    alias dots-hide-untracked='/usr/bin/git --git-dir=$HOME/.dots --work-tree=$HOME config --local status.showUntrackedFiles no'

    dots checkout

    if [ $? -eq 0 ]; then
        _clr green "Successfully configured dotfiles"
    else
        _clr red "Failed to configure dotfiles"
        _clr purple "NOTE: if any of the files already exists, try deleting them first and try again"
        return 1
    fi

    echo -e "\n\n[[ ! -f ~/shell.cfg ]] || source ~/shell.cfg;\n\n" >>~/.bashrc
    source ~/.bashrc
}

setup_zsh() {
    echo " "
    _clr cyan "Installing zsh"
    echo " "
    yay --needed --noconfirm -S zsh
    if [ $? -eq 0 ]; then
        _clr green "Successfully installed zsh"
    else
        _clr red "Failed to install zsh"
        return 1
    fi

    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
    echo -e "\n\n[[ ! -f ~/shell.cfg ]] || source ~/shell.cfg;\n\n" >>~/.zshrc
}

install_hyrpland() {
    echo " "
    _clr cyan "Installing hyprland and essential dependencies ..."
    echo " "
    # swwww (wallpaper animation), make (notification)
    # grim,slurp, wl-clipboard (screenshot)
    # pamixer(vol control notification ), xorg-wayland(for some non-wayland app)
    #
    yay --needed --noconfirm -S \
        hyprland waybar-hyprland-git waybar rofi-lbonn-wayland-git \
        swaybg swww swaylock-effects wlroots wlogout polkit-kde-agent \
        mako grim slurp wl-clipboard mpv \
        pamixer pipewire xdg-user-dirs xorg-wayland \
        dunst wlsunset swayidle udev-block-notify \
        playerctl blueman-applet brightnessctl \
        wireplumber xdg-desktop-portal-wlr wl-copy networkmanager \
        alacritty
}

uninstall_hyprland() {
    echo " "
    _clr cyan "Uninstalling hyprland and dependencies ..."
    echo " "
    yay --noconfirm -Rns hyprland waybar-hyprland-git \
        swaybg swww swaylock-effects wlroots wlogout \
        mako grim slurp wl-clipboard wofi dunst wlsunset swayidle \
        xdg-desktop-portal-wlr
}

install_bspwm() {
    echo " "
    _clr cyan "Installing Bspwm and essential dependencies ..."
    echo " "
    yay --needed --noconfirm -S \
        bspwm-rounded-corners sxhkd rofi-lbonn-wayland-git \
        alacritty kitty feh mpv dunst polkit-gnome playerctl pamixer \
        xorg-xprop xclip xsel xorg-xkill xdotool xorg-xsetroot xorg-xwininfo xorg-xrandr mpc mpd \
        sddm qt5-graphicaleffects qt5-quickcontrols2 qt5-svg i3lock \
        exa light network-manager-applet gtk3 gtk4 libconfig pkgconfig
    
   # Installing picom 
   rm -rf ~/Downloads/picom
   git clone https://github.com/jonaburg/picom ~/Downloads/picom
   cd ~/Downloads/picom
   meson --buildtype=release . build
   ninja -C build
   sudo ninja -C build install
}

while true; do
    echo " "
    # Prompt user for function choice
    _clr cyan "Choose a function to run:"
    _clr yellow " 1.  Update system"
    _clr yellow " 2.  Install yay"
    _clr yellow " 3.  Install core pkgs"
    _clr yellow " 4.  Mount NTFS storage"
    _clr yellow " 5.  Setup SDDM"
    _clr yellow " 6.  Setup Firewall"
    _clr yellow " 7.  Setup Tmux"
    _clr yellow " 8.  Setup Dotfiles"
    _clr yellow " 9.  Install ZSH"
    _clr yellow "10.  Install Hyprland"
    _clr yellow "11.  Uninstall Hyprland"
    _clr yellow "12.  Install Bspwm"
    echo " "
    _clr purple "0. Quit or Ctrl+C"
    read -p "Option number: " choice

    case $choice in
    1)
        update_system
        ;;
    2)
        install_yay
        ;;
    3)
        install_core_pkgs
        ;;
    4)
        mount_ntfs_storage
        ;;
    5)
        setup_sddm
        ;;
    6)
        setup_firewall
        ;;
    7)
        setup_tmux
        ;;
    8)
        setup_dotfiles_repo
        ;;
    9)
        setup_zsh
        ;;
    10)
        install_hyrpland
        ;;
    11)
        uninstall_hyprland
        ;;
    12)
        install_bspwm
        ;;
    0)
        break
        ;;
    *)
        _clr red "Invalid choice. Please choose a valid option."
        ;;
    esac
done

_clr green "Script execution complete. Exiting..."
