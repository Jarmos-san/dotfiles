local opt = vim.opt

opt.number = true -- Display the row number on the left side of the window
opt.relativenumber = true -- Display the row number relative to the up/down rows
opt.autowrite = true -- Save the contents of the buffer after exiting Insert mode
opt.clipboard = "unnamedplus" -- Sync the system clipboard with Neovim
opt.laststatus = 3 -- Enable the global status line
opt.scrolloff = 6 -- Maintain a buffer of rows between the current row & the either ends of the window
opt.completeopt = "menu,menuone,noselect" -- Make the autocompletion window more accessible
opt.conceallevel = 3 -- Hide the * markups for bold & italics
opt.confirm = true -- Prompt to save the contents of the buffer before exiting
opt.expandtab = true -- Use spaces instead of tabs
-- TODO: Figure out what purpose does it serve
-- opt.formatoptions = "jcroqlnt" -- Some formatting configuration, needs more research
opt.ignorecase = true -- Ignore casing when searching for a word
opt.inccommand = "nosplit" -- Preview incremental substitute
opt.list = true -- Show invisible whitespace characters
opt.pumblend = 10 -- Make the completion popup window a bit transparent
opt.pumheight = 10 -- Display only 10 rows for the completion menu
opt.shiftround = true -- Roundup indentations
-- TODO: Figure a way out to configure these options specific to the filetype instead
opt.shiftwidth = 2 -- The default size of an indentation (this will be configure per filetype later on)
opt.tabstop = 2 -- Number of Spaces, a single tab counts for
opt.showmode = false -- Disable showing the current mode since its already visible on the statusline
opt.signcolumn = "yes" -- Allow the sign column to show else it'll keep shifting later on
opt.smartcase = true -- Don't ignore casing with capitals
opt.spelllang = { "en" } -- The language to use when spelling checking
opt.splitbelow = true -- Put new windows below current
opt.splitright = true -- Put new windows right of the current
opt.termguicolors = true -- True color support for various plugins
opt.timeoutlen = 300 -- ??
opt.undofile = true -- ??
opt.undolevels = 10000 -- ??
opt.updatetime = 200 -- Save swap file & trigger CursorHold
opt.wildmode = "longest:full,full" -- Command-line completion mode
opt.winminwidth = 5 -- Maximum window width
opt.iskeyword:append("-") -- Make Neovim recognise dash-seperated words as a single word

vim.notify = require("notify")
