colorscheme pablo

set background=dark
set nocp
set clipboard=unnamed
set wildmenu
set backspace=indent,eol,start
set gdefault
set encoding=utf-8 nobomb
set number relativenumber
set tabstop=2
set hlsearch incsearch
set ignorecase
set noerrorbells
set nostartofline
set ruler
set shortmess=atI
set showcmd
set scrolloff=6

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

if has("autocmd")
	" Enable file type detection
	filetype on
	" Treat .json files as .js
	autocmd BufNewFile,BufRead *.json setfiletype json syntax=javascript
	"Treat .md files as markdown
	autocmd BufNewFile,BufRead *.md setlocal filetype=markdown
endif
