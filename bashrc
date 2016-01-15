# .bash_profile - Jesse Robertson - 20 April 2015

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
AddPath $HOME/.conda/bin
function unconda {
    export PATH=`echo ":${PATH}:" | \
    sed -e "s:\:$HOME/.conda/bin\::\::g" -e "s/^://" -e "s/:$//"`
}
function reconda {
    export PATH="$HOME/.conda/bin:$PATH"
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
export CC=clang
export CFLAGS="-Wall -std=c11"
export CFLAGS_DEBUG="-g"
#export CXX=clang++
#export CXXFLAGS="-Wall"
#export CXXFLAGS_DEBUG="-g"

# Start up ssh agent
eval $(ssh-agent) &> /dev/null

# Some stuff for Mac
export HOMEBREW_GITHUB_API_TOKEN='ddb1f1e0edf7ee2ed5041cd9045d740e401f39b3'

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

# Add autojump
# This needs be done last because autojump modifies the prompt command
# to track directories
[[ -s "${HOME}/.autojump/etc/profile.d/autojump.sh" ]] \
    && source "${HOME}/.autojump/etc/profile.d/autojump.sh"

