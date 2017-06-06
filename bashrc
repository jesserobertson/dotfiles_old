# .bash_profile - Jesse Robertson - 20 April 2015

## SOURCE RELEVANT FILES

SourceIfExists () 
# Source a file if it exists
{
  _file=$1
  [[ -s "$_file" ]] && source "$_file"
}

# Add git completion
SourceIfExists "~/.local/bin/git-completion.bash"

## SET UP PATH

AddPath ()
# Add argument to $PATH if:
# - it is not already present
# - it is a directory
# - we have execute permission on it
{
  _folder=$1
  echo " $PATH " | sed 's/:/ /g' | grep " $_folder " > /dev/null
  [ $? -ne 0 ] && [ -d $_folder ] && [ -x $_folder ] && PATH=$_folder:$PATH
  export PATH
}

# Add some paths. Last excecuted is first in line in path
AddPath /usr/bin
AddPath /usr/local/bin
AddPath $HOME/.local/bin

# Add rbenv for ruby
AddPath $HOME/.rbenv/bin
AddPath $HOME/.rbenv/versions/2.2.2/bin

# Add node.js - when building do `./configure --prefix=~/.node`
AddPath $HOME/.node/bin

# Add anaconda, with functions to add and remove as you like
AddPath $HOME/.local/conda/bin
function unconda {
    export PATH=`echo ":${PATH}:" | \
    sed -e "s:\:$HOME/.local/conda/bin\::\::g" -e "s/^://" -e "s/:$//"`
}
function reconda {
    export PATH="$HOME/.local/conda/bin:$PATH"
}

# We can make sure that libraries are installed locally
export PREFIX=$HOME/.local

# We also need to update the library path and pkg config for
# locallaly installed packages
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$HOME/.local/lib
export PKG_CONFIG_PATH=$PKG_CONFIG_PATH:$HOME/.local/lib/pkgconfig

# # Add PETSc and SlepC
# export PETSC_DIR=/home/src/petsc 
# export PETSC_ARCH=arch-linux2-c-opt

# And we want things to compile with clang
function clangify {
    export CC=clang
    export CFLAGS="-Wall -std=c11"
    export CFLAGS_DEBUG="-g"
    export CXX=clang++
    export CXXFLAGS="-Wall"
    export CXXFLAGS_DEBUG="-g"
}
function declangify {
    export CC=gcc
    export CFLAGS=
    export CFLAGS_DEBUG=
    export CXX=g++
    export CXXFLAGS=
    export CXXFLAGS_DEBUG=-g
}

# Load Intel Parallel Studio
function source_intel {
    export INTEL_INSTALL='/opt/intel/'
    export PSXE_DIR='parallel_studio_xe_2017.0.035'
    source ${INTEL_INSTALL}/${PSXE_DIR}/bin/psxevars.sh
}

# Start up ssh agent
eval $(ssh-agent) &> /dev/null

# Some stuff for Mac
export HOMEBREW_GITHUB_API_TOKEN='ddb1f1e0edf7ee2ed5041cd9045d740e401f39b3'

# Add some stuff for barracuda i3 setup
alias fixit='sudo rm -f /var/lib/pacman/db.lck'
alias update='yaourt -Syua'
alias mirrors='sudo pacman-mirrors -g'
alias printer='system-config-printer'
alias i3config='vi $HOME/.i3/config'

# # Boot2docker
# export DOCKER_HOST=tcp://$(boot2docker ip 2>/dev/null):2376
# export DOCKER_CERT_PATH=$HOME/.boot2docker/certs/boot2docker-vm
# export DOCKER_TLS_VERIFY=1

## ENVIRONMENT VARIABLES

declare -x LS_COLORS='no=01;37:fi=01;37:di=01;34:ln=01;36:pi=01;32:so=01;35:do=01;35:bd=01;33:cd=01;33:ex=01;31:mi=00;37:or=00;36:'
declare -x PAGER='less'
declare -x EDITOR='vim'
declare -x VISUAL="${EDITOR}"
declare -x FCEDIT="${EDITOR}"
declare -x HISTFILE=~/.bash_history
declare -x HISTCONTROL=ignoreboth
declare -x HISTFILESIZE=150
declare -x HISTSIZE=150

unset PROMPT_COMMAND

## SHELL VARIABLES

umask 077
ulimit -c 0
set -o noclobber
set -o physical

shopt -s cdspell
shopt -s extglob
shopt -s dotglob
shopt -s cmdhist
shopt -s lithist
shopt -s progcomp
shopt -s checkhash
shopt -s histreedit
shopt -s promptvars
shopt -s cdable_vars
shopt -s checkwinsize
shopt -s hostcomplete
shopt -s expand_aliases
shopt -s interactive_comments

## FUNCTIONS AND ALIASES

function    rmd              { rm -fr $@; }

function    x                { exit    $@; }
function    z                { suspend $@; }

function    osr              { shutdown -r now; }
function    osh              { shutdown -h now; }

function    ss               { sudo -s; }

function    p                { ${PAGER}  $@; }
function    e                { ${EDITOR} $@; }

function    c                { clear; }
function    h                { history $@; }
function    hc               { history -c; }
function    hcc              { hc;c; }

function    cx               { hc;x; }
function    ..               { cd ..; }
function	cdl              { cd $@ && ls;}

function    ll               { ls -FAql $@; }
function    lf               { ls -FAq  $@; }

function    mfloppy          { mount /dev/fd0 /mnt/floppy; }
function    umfloppy         { umount /mnt/floppy; }

function    mdvd             { mount -t iso9660 -o ro /dev/dvd /mnt/dvd; }
function    umdvd            { umount /mnt/dvd; }

function    mcdrom           { mount -t iso9660 -o ro /dev/cdrom /mnt/cdrom; }
function    umcdrom          { umount /mnt/cdrom; }

function    miso             { mount -t iso9660 -o ro,loop $@ /mnt/iso; }
function    umiso            { umount /mnt/iso; }

function    ff               { find . -name $@ -print; }

function    psa              { ps aux $@; }
function    psu              { ps  ux $@; }

function    lpsa             { ps aux $@ | p; }
function    lpsu             { ps  ux $@ | p; }

function    dub              { du -sclb $@; }
function    duk              { du -sclk $@; }
function    dum              { du -sclm $@; }
function    duh              { du -sclh $@; }

function    dfk              { df -PTak $@; }
function    dfm              { df -PTam $@; }
function    dfh              { df -PTah $@; }
function    dfi              { df -PTai $@; }

function    dmsg             { dmesg | p; }

function    kernfs           { p /proc/filesystems; }
function    shells           { p /etc/shells; }

function    lfstab           { p /etc/fstab; }
function    lxconf           { p /etc/X11/xorg.conf; }

if [ `id -u` -eq 0 ]
then
    function    efstab       { e /etc/fstab; }
    function    exconf       { e /etc/X11/xorg.conf; }
    function    txconf       { X -probeonly; }
fi
## COMPLETIONS

# Start bash completion
if [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
fi

## PROMPT
# color_name='\[\033[ color_code m\]'

rgb_restore='\[\033[00m\]'
rgb_black='\[\033[00;30m\]'
rgb_firebrick='\[\033[00;31m\]'
rgb_red='\[\033[01;31m\]'
rgb_forest='\[\033[00;32m\]'
rgb_green='\[\033[01;32m\]'
rgb_brown='\[\033[00;33m\]'
rgb_yellow='\[\033[01;33m\]'
rgb_navy='\[\033[00;34m\]'
rgb_blue='\[\033[01;34m\]'
rgb_purple='\[\033[00;35m\]'
rgb_magenta='\[\033[01;35m\]'
rgb_cadet='\[\033[00;36m\]'
rgb_cyan='\[\033[01;36m\]'
rgb_gray='\[\033[00;37m\]'
rgb_white='\[\033[01;37m\]'

rgb_std="${rgb_black}"

if [ `id -u` -eq 0 ]
then
    rgb_usr="${rgb_red}"
else
    rgb_usr="${rgb_forest}"
fi

[ -n "$PS1" ] && PS1="\n${rgb_usr}`id -un`@\h${rgb_restore} \w\n ${rgb_usr}\! >:${rgb_restore} "

unset   rgb_restore   \
        rgb_black     \
        rgb_firebrick \
        rgb_red       \
        rgb_forest    \
        rgb_green     \
        rgb_brown     \
        rgb_yellow    \
        rgb_navy      \
        rgb_blue      \
        rgb_purple    \
        rgb_magenta   \
        rgb_cadet     \
        rgb_cyan      \
        rgb_gray      \
        rgb_white     \
        rgb_std       \
        rgb_usr

# Base16 Ocean - Shell color setup script
# Chris Kempson (http://chriskempson.com)

if [ "${TERM%%-*}" = 'linux' ]; then
    # This script doesn't support linux console (use 'vconsole' template instead)
    return 2>/dev/null || exit 0
fi

color00="2b/30/3b" # Base 00 - Black
color01="bf/61/6a" # Base 08 - Red
color02="a3/be/8c" # Base 0B - Green
color03="eb/cb/8b" # Base 0A - Yellow
color04="8f/a1/b3" # Base 0D - Blue
color05="b4/8e/ad" # Base 0E - Magenta
color06="96/b5/b4" # Base 0C - Cyan
color07="c0/c5/ce" # Base 05 - White
color08="65/73/7e" # Base 03 - Bright Black
color09=$color01 # Base 08 - Bright Red
color10=$color02 # Base 0B - Bright Green
color11=$color03 # Base 0A - Bright Yellow
color12=$color04 # Base 0D - Bright Blue
color13=$color05 # Base 0E - Bright Magenta
color14=$color06 # Base 0C - Bright Cyan
color15="ef/f1/f5" # Base 07 - Bright White
color16="d0/87/70" # Base 09
color17="ab/79/67" # Base 0F
color18="34/3d/46" # Base 01
color19="4f/5b/66" # Base 02
color20="a7/ad/ba" # Base 04
color21="df/e1/e8" # Base 06
color_foreground="c0/c5/ce" # Base 05
color_background="2b/30/3b" # Base 00
color_cursor="c0/c5/ce" # Base 05

if [ -n "$TMUX" ]; then
  # tell tmux to pass the escape sequences through
  # (Source: http://permalink.gmane.org/gmane.comp.terminal-emulators.tmux.user/1324)
  printf_template="\033Ptmux;\033\033]4;%d;rgb:%s\007\033\\"
  printf_template_var="\033Ptmux;\033\033]%d;rgb:%s\007\033\\"
  printf_template_custom="\033Ptmux;\033\033]%s%s\007\033\\"
elif [ "${TERM%%-*}" = "screen" ]; then
  # GNU screen (screen, screen-256color, screen-256color-bce)
  printf_template="\033P\033]4;%d;rgb:%s\007\033\\"
  printf_template_var="\033P\033]%d;rgb:%s\007\033\\"
  printf_template_custom="\033P\033]%s%s\007\033\\"
else
  printf_template="\033]4;%d;rgb:%s\033\\"
  printf_template_var="\033]%d;rgb:%s\033\\"
  printf_template_custom="\033]%s%s\033\\"
fi

# 16 color space
printf $printf_template 0  $color00
printf $printf_template 1  $color01
printf $printf_template 2  $color02
printf $printf_template 3  $color03
printf $printf_template 4  $color04
printf $printf_template 5  $color05
printf $printf_template 6  $color06
printf $printf_template 7  $color07
printf $printf_template 8  $color08
printf $printf_template 9  $color09
printf $printf_template 10 $color10
printf $printf_template 11 $color11
printf $printf_template 12 $color12
printf $printf_template 13 $color13
printf $printf_template 14 $color14
printf $printf_template 15 $color15

# 256 color space
printf $printf_template 16 $color16
printf $printf_template 17 $color17
printf $printf_template 18 $color18
printf $printf_template 19 $color19
printf $printf_template 20 $color20
printf $printf_template 21 $color21

# foreground / background / cursor color
if [ -n "$ITERM_SESSION_ID" ]; then
  # iTerm2 proprietary escape codes
  printf $printf_template_custom Pg c0c5ce # forground
  printf $printf_template_custom Ph 2b303b # background
  printf $printf_template_custom Pi c0c5ce # bold color
  printf $printf_template_custom Pj 4f5b66 # selection color
  printf $printf_template_custom Pk c0c5ce # selected text color
  printf $printf_template_custom Pl c0c5ce # cursor
  printf $printf_template_custom Pm 2b303b # cursor text
else
  printf $printf_template_var 10 $color_foreground
  printf $printf_template_var 11 $color_background
  printf $printf_template_var 12 $color_cursor
fi

# clean up
unset printf_template
unset printf_template_var
unset color00
unset color01
unset color02
unset color03
unset color04
unset color05
unset color06
unset color07
unset color08
unset color09
unset color10
unset color11
unset color12
unset color13
unset color14
unset color15
unset color16
unset color17
unset color18
unset color19
unset color20
unset color21
unset color_foreground
unset color_background
unset color_cursor

# Add autojump
# This needs be done last because autojump modifies the prompt command
# to track directories
[[ -s "/usr/share/autojump/autojump.bash" ]] \
    && source "/usr/share/autojump/autojump.bash"

