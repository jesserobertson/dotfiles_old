set nocompatible
filetype off

" modified bootstrap, originally from John Whitley
" https://github.com/jwhitely/vimrc/blob/master/.vim/bootstrap/bundles.vim
let s:current_folder = expand("<sfile>:h")

" returns path inside .vim folder relative to this file
function! s:RelativePathWithinDotVim(path)
	return s:current_folder."/.vim/".a:path
endfunction

" initialize vundle if we haven't yet
let s:bundle_path = s:RelativePathWithinDotVim("bundle")
let s:vundle_path = s:RelativePathWithinDotVim("bundle/Vundle.vim")
if !isdirectory(s:vundle_path."/.git")
	silent exec "!mkdir -p ".s:bundle_path
	silent exec "!git clone --depth=1 https://github.com/gmarik/Vundle.vim.git ".s:vundle_path
	let s:vundle_initialized = 1
endif

exec "set rtp+=".s:vundle_path
call vundle#begin(s:bundle_path)

" let vundle manage itself
Plugin 'gmarik/Vundle.vim'

" other plugins...

" post-run hooks
call vundle#end()
filetype plugin indent on
