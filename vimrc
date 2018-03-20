" Use pathogen to manage plugins
set nocompatible    " be iMproved, required by Vundle
filetype off        " required

" vimrc-fu to bootstrap vundle to install plugins
" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
let s:bootstrap = 0
try
    call vundle#begin()
catch /E117:/
    let s:bootstrap = 1
    silent !mkdir -p ~/.vim/bundle
    silent ~unset GIT_DIR && git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
    redraw!
    call vundle#begin()
endtry

" let Vundle manage vundle
Plugin 'VundleVim/Vundle.vim'

" ...other plugins
Bundle 'chrostoomey/vim-tmux-navigator'

" Vundle end hooks
call vundle#end()
if s:bootstrap
    silent PluginInstall
    quit
end
filetype plugin indent on

" basic settings
syntax enable 	    " Turn on syntax highlighing
set number          " Turn on line numbering
set tabstop=4       " number of visual spaces per tab
set softtabstop=4   " number of spaces in tab when editing
set expandtab       " tabs are spaces

set wildmenu        " visual autocomplete for command menu
set lazyredraw      " redraw only when we need to
set showmatch       " highlight matchin [{()}]

" search as characters are entered, highlight matches
" turn off search highlight with ,<space>
set incsearch
set hlsearch
nnoremap <leader><space> :nohlsearch<CR>

set hidden          " Leave hidden buffers open
set history=100     " By default Vim saves last 8 commands, we can handle more
set backup          " Save backups but to /tmp dir
set backupdir=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp
set backupskip=/tmp/*,/private/tmp/*
set directory=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp
set writebackup

" shortcuts
let mapleader=","   " \ is too far away, use , instead

