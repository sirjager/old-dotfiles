#!/bin/bash

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
    "blue")
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

_log() {
    if [ "$1" != "" ]; then
        if [ "$2" != "" ]; then
            echo
            _clr yellow "$(date)"
            _clr $1 "$2"
        else
            echo -e "$(date): $1"
        fi
    fi

    if [ "$3" == "exit" ]; then
        if [ "$4" == "0" ]; then
            exit 0
        else
            exit 1
        fi
    fi
}

update_system() {
    echo
    _log blue "Updating system\n"
    sudo pacman -Syyu
}

install_yay() {
    echo
    _log blue "Installing yay package manager\n"
    sudo pacman --needed --noconfirm -S yay &&
        _log green "Installed yay successfully\n" ||
        _log red "Failed to install yay" exit
}

install_core_pkgs() {
    echo
    _log blue "Installing core packages\n"

    yay --needed --noconfirm -S base-devel libconfig pkgconfig &&
        _log green "Installed:\nbase-devel libconfig pkgconfig \n" ||
        _log red "Failed to install\nbase-devel libconfig pkgconfig \n"
    yay --needed --noconfirm -S \
        wget curl htop git xclip xorg-xinput xorg-xsetroot xsel &&
        _log green "Installed:\nwget curl htop git xclip xorg-xinput xorg-xsetroot xsel \n" ||
        _log red "Failed to install\nwget curl htop git xclip xorg-xinput xorg-xsetroot xsel \n"
    yay --needed --noconfirm -S \
        mpv exa light network-manager-applet zsh &&
        _log green "Installed:\nmpv exa light network-manager-applet zsh \n" ||
        _log red "Failed to install\nmpv exa light network-manager-applet zsh \n"
    yay --needed --noconfirm -S \
        alacritty kitty emacs neovim tmux lazygit fzf &&
        _log green "Installed:\nalacritty kitty emacs neovim tmux lazygit fzf  \n" ||
        _log red "Failed to install\nalacritty kitty emacs neovim tmux lazygit fzf \n"
}

mount_ntfs_storage() {
    echo
    TARGET_NTFS_STORAGE_NAME="STORAGE"
    MOUNT_TARGETED_NTFS_AT_THIS_PATH=/mnt/storage
    NTFS_DRIVE_UUID=$(sudo blkid -s UUID -o value -l -c /dev/null -t LABEL="$TARGET_NTFS_STORAGE_NAME")
    if [ -n "$NTFS_DRIVE_UUID" ]; then
        # Append the entry to /etc/fstab using the stored UUID
        sudo mkdir -p $MOUNT_TARGETED_NTFS_AT_THIS_PATH
        echo "UUID=$NTFS_DRIVE_UUID $MOUNT_TARGETED_NTFS_AT_THIS_PATH ntfs defaults 0 1" | sudo tee -a /etc/fstab
        sudo systemctl daemon-reload
        sudo mount -a
        _log green "Successfully mounted $TARGET_NTFS_STORAGE_NAME ($NTFS_DRIVE_UUID) at path $MOUNT_TARGETED_NTFS_AT_THIS_PATH\n"
    else
        _log red "Error: Unable to retrieve the UUID for the '$TARGET_NTFS_STORAGE_NAME' partition.\n"
    fi
}

install_and_setup_sddm() {
    echo
    _log blue "Installing SDDM and required dependencies"
    yay --needed --noconfirm -S S sddm qt5-graphicaleffects qt5-quickcontrols2 qt5-svg
    if [ $? -eq 0 ]; then
        _log green "Successfully installed SDDM"
    else
        _log red "Failed to install SDDM"
        return 1
    fi
    _log yellow "Trying to disable other lock screen managers\n"
    sudo systemctl disable lightdm
    sudo systemctl disable gdm
    echo
    _log yellow "Enabling sddm service\n"
    sudo systemctl enable sddm
    echo

    _log yellow "Downloading sddm theme sugar-candy"
    rm -rf ~/Downloads/sugar-candy
    git clone https://github.com/Kangie/sddm-sugar-candy ~/Downloads/sugar-candy
    _log yellow "Applying sddm theme configs\n"
    echo 'Background="/mnt/storage/wallpaper/sddm.png"' >>~Downloads/sugar-candy/theme.conf
    echo 'PartialBlur="false"' >>~/Downloads/sugar-candy/theme.conf
    cp -f /usr/lib/sddm/sddm.conf.d/default.conf ~/Downloads/sugar-candy/sddm.conf
    echo -e '\n[Theme]\nCurrent=sugar-candy' >>~/Downloads/sugar-candy/sddm.conf
    echo -e '\n[General]\nNumlock=on' >>~/Downloads/sugar-candy/sddm.conf
    sudo rm -f /etc/sddm.conf
    sudo cp -f ~/Downloads/sugar-candy/sddm.conf /etc/sddm.conf
    sudo mv ~/Downloads/sugar-candy /usr/share/sddm/themes/sugar-candy
    _log green "Successfully installed and configured SDDM Lock screen manager\n"
}

install_firewall() {
    echo
    _log yellow "Removing other firewalls\n"
    yay --noconfirm -Rns firewalld
    _log blue "Installing Graphical Firewall (gufw)\n"
    yay --noconfirm --needed -S gufw
    _log yellow "Enabling Firewall\n"
    sudo systemctl enable --now ufw
    _log green "Firewall is now active\n"
}

setup_tmux() {
    echo " "
    _log cyan "Installing Tmux"
    echo " "
    yay --needed --noconfirm -S tmux
    if [ $? -eq 0 ]; then
        _log green "Successfully installed tmux"
    else
        _log red "Failed to install tmux"
        return 1
    fi

    _log purple "Setting up Tmuxifier..."
    rm -rf ~/.tmuxifier
    git clone https://github.com/jimeh/tmuxifier.git ~/.tmuxifier

    # Tmux Plugin Manager
    _log purple "Setting up TPM (Tmux Plugin Manager)"
    rm -rf ~/.tmux/plugins/tpm
    git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

    _log green "Tmux successfully installed and configured"
}

install_bspwm() {
    echo
    _log blue "Installing Bspwm and required dependcies\n"
    yay --needed --noconfirm -S \
        bspwm-rounded-corners polybar sxhkd rofi-lbonn-wayland-git \
        alacritty kitty feh mpv dunst polkit-gnome playerctl pamixer \
        xorg-xprop xclip xsel xorg-xkill xdotool xorg-xsetroot xorg-xwininfo xorg-xrandr mpc mpd \
        sddm qt5-graphicaleffects qt5-quickcontrols2 qt5-svg i3lock \
        exa thunar light network-manager-applet gtk3 gtk4 libconfig pkgconfig

    # Installing picom
    rm -rf ~/Downloads/picom
    git clone https://github.com/jonaburg/picom ~/Downloads/picom
    cd ~/Downloads/picom
    meson --buildtype=release . build
    ninja -C build
    sudo ninja -C build install
}

setup_zsh() {
    echo " "
    _log cyan "Installing zsh\n"
    echo " "
    yay --needed --noconfirm -S zsh
    if [ $? -eq 0 ]; then
        _log green "Successfully installed zsh\n"
    else
        _log red "Failed to install zsh\n"
        return 1
    fi
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
}

setup_dotfiles_repo() {
    GITHUB_BARE_REPO="git@github.com:sirjager/.dots"
    echo
    _log cyan "Setting up dotfiles bare repository"
    echo " "

    rm -rf ~/.dots
    _log purple "Cloning github repository $GITHUB_BARE_REPO ...\n"
    git clone --bare $GITHUB_BARE_REPO ~/.dots

    alias dots='/usr/bin/git --git-dir=$HOME/.dots --work-tree=$HOME'
    alias dots-hide-untracked='/usr/bin/git --git-dir=$HOME/.dots --work-tree=$HOME config --local status.showUntrackedFiles no'

    dots checkout

    if [ $? -eq 0 ]; then
        _log green "Successfully configured dotfiles\n"
    else
        _log red "Failed to configure dotfiles"
        _log purple "NOTE: if any of the files already exists, try deleting them first and try again"
        return 1
    fi

    echo -e "\n\n[[ ! -f ~/shell.cfg ]] || source ~/shell.cfg;\n\n" >>~/.bashrc
    echo -e "\n\n[[ ! -f ~/shell.cfg ]] || source ~/shell.cfg;\n\n" >>~/.zshrc
    source ~/.bashrc
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
    _clr yellow "10.  Install Bspwm"
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
        install_and_setup_sddm
        ;;
    6)
        install_firewall
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
        install_bspwm
        ;;
    0)
        break
        ;;
    *)
        _log red "Invalid choice. Please choose a valid option."
        ;;
    esac
done

_log green "Script execution complete. Exiting..." exit 0
