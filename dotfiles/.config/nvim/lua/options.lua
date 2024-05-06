local opt = vim.opt

-- Sync the system clipboard with Neovim
opt.clipboard = "unnamedplus"

-- Enable the global status line
opt.laststatus = 3

-- Make the autocompletion window more accessible
opt.completeopt = "menu,menuone,noselect"

-- Hide the * markups for bold & italics
opt.conceallevel = 3

-- Case-insensitive searching UNLESS \C or one or more capital letters in the search term
opt.ignorecase = true
opt.smartcase = true

-- Preview substitutions as its typed
opt.inccommand = "split"

-- The language to use when spelling checking
opt.spelllang = { "en" }

-- Configure how new splits should be opened
opt.splitbelow = true
opt.splitright = true

-- Decrease mapped sequence wait time to display which-key popup sooner
opt.timeoutlen = 300

-- Save undo history
opt.undofile = true
opt.undolevels = 10000

-- Save swap file & trigger CursorHold
opt.updatetime = 200

-- Command-line completion mode
opt.wildmode = "longest:full,full"

-- Maximum window width
opt.winminwidth = 5

--Disable swapfile creation since it gets annoying after a while
opt.swapfile = false

-- Configure Neovim to highlight the current location of the cursor
opt.cursorline = true

-- True color support for various plugins
opt.termguicolors = true

-- Make the completion popup window a bit transparent
opt.pumblend = 10

-- Display only 10 rows for the completion menu
opt.pumheight = 10

-- Disable showing the current mode since its already visible on the statusline
opt.showmode = false

-- Disable prompting the invoked command back to the user
opt.showcmd = false

-- Disable showing the current location of the cursor since the Lualine plugin takes care of it
opt.ruler = false

-- Configure Neovim to not wrap the contents of the buffer
opt.wrap = false

-- Add a slight padding to wrapped lines to distinguish them from the rest of the lines
opt.showbreak = "...."

-- Save the contents of the buffer after exiting Insert mode
opt.autowrite = true

-- Prompt to save the contents of the buffer before exiting
opt.confirm = true

-- Enable horinzontal scrolling when word wrap is disabled
opt.sidescroll = 8

-- FIXME: The following option might only be useful in certain filetypes like JSX, Markdown and such
-- Make Neovim recognise dash-seperated words as a single word
opt.iskeyword:append("-")

-- Maintain a buffer of rows between the current row & the either ends of the window
opt.scrolloff = 6

-- Enable the current line number to be shown
opt.number = true
opt.relativenumber = true

-- Allow the sign column to show else it'll keep shifting later on
opt.signcolumn = "yes"

-- Explicitly tell Neovim to use ZSH for terminal commands instead of relying on $SHELL
opt.shell = "zsh"

-- Enable break indent
vim.opt.breakindent = true

-- Sets how neovim will display certain whitespace characters in the editor.
vim.opt.list = true
vim.opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }

-- FIXME: Figure a way out to disable the statusline in the "starter" buffer
-- Set the statusline
vim.o.statusline = "%!v:lua.require('statusline').render()"
