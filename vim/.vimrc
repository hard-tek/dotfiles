
"Sets default clipboard to the system clipboard
set clipboard=unnamedplus

"Set compatibility to Vim only
set nocompatible
syntax on 

" Show line numbers
set relativenumber

" Status bar
set laststatus=2

"Split Ctrl+W+V
set splitbelow splitright

" Automatically wrap text
set wrap

" Encoding
set encoding=utf-8

" Call the .vimrc.plug file
if filereadable(expand("~/.vimrc.plug"))
	source ~/.vimrc.plug
endif


