" Replace this file with a Lua file when Neovim v0.7 drops by.
" But in case there's enough interest to implement a Lua version of the file,
" then refer to the following resources:
" 1. https://gist.github.com/numToStr/1ab83dd2e919de9235f9f774ef8076da
" 2. https://github.com/nanotee/nvim-lua-guide#defining-autocommands

autocmd BufNewFile,BufRead *.json setlocal filetype=json
autocmd BufNewFile,BufRead *.jsonc setlocal filetype=json
