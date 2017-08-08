# system setup

Download and install dotfiles from github

### Installing i3

Install with apt:

```bash
sudo apt install i3 i3blocks i3status lxappearence feh
```

### Installing clean i3 styles

Installing icons and styles - first install arc theme with `sudo apt install arc-theme`. Arc theme also wants the arc icons and moka icons. Install moka with 

```
sudo add-apt-repository ppa:moka/daily
sudo apt-get update
sudo apt-get install moka-icon-theme faba-icon-theme fonts-font-awesome
```

then install arc icons with autotools

```
sudo apt install autotools-dev automake autoconf libtool git
git clone https://github.com/horst3180/arc-icon-theme --depth 1 && cd arc-icon-theme
./autogen.sh --prefix=/usr
sudo make install
```

Install compton `sudo apt install compton` for compositing

### Install launcher - rofi

`sudo apt install rofi`

### Linking all the things

You might need to change the value of `$HOME` in some of the scripts.

```bash
ln -s ~/.dotfiles/fonts ~/.fonts
ln -s ~/.dotfiles/i3 ~/.i3
ln -s ~/.dotfiles/compton.conf ~/.compton.conf
ln -s ~/.dotfiles/wallpaper.png ~/.wallpaper.png
```

