colorscheme pablo

set background=dark
set nocompatible
set clipboard=unnamed		" Use OS clipboard
set wildmenu			" Enable tab completion for CLI
set backspace=indent,eol,start	" Enable Backspace in Insert mode
set gdefault			" Add the g flag to search/replace by default
set encoding=utf-8 nobomb 	" Use UTF-8 without BOM
set binary
set noeol
set number relativenumber
set tabstop=2
set lcs=tab:▸\ ,trail:·,eol:¬,nbsp:_	" Show 'invisible' characters
set list
set hlsearch incsearch
set ignorecase
set noerrorbells
set nostartofline
set ruler
set shortmess=atI
set title
set showcmd
set scrolloff=3

let mapleader=" "

" Strip trailing whitespace
function! StripWhitespace()
	let save_cursor = getpos(".")
	let old_query = getreg("/")
	:%s/\s\+$//e
	call setpos('.', save_cursor)
	call setreg('/', old_query)
endfunction

noremap <leader>ss :call StripWhitespace()<CR>

" Save a file as root
noremap <leader>W :w !sudo tee % > /dev/null<CR>

" Autocommands
if has("autocmd")
	" Enable file type detection
	filetype on
	" Treat .json files as .js
	autocmd BufNewFile,BufRead *.json setfiletype json syntax=javascript
	"Treat .md files as markdown
	autocmd BufNewFile,BufRead *.md setlocal filetype=markdown
endif