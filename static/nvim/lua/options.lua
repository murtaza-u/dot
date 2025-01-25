local o = vim.opt

-- automatically write files when multiple files are changed
o.autowrite = true

-- no line wrapping
o.wrap = false

-- 80 char column
o.colorcolumn = "80"

-- no automatic folding
o.foldmethod = "manual"
o.foldenable = false

-- sensible split positions
o.splitbelow = true
o.splitright = true

-- maximum number of items to show in the popup menu
o.pumheight = 10

-- height of command-line
o.cmdheight = 1

o.smarttab = true

-- replace tabs with spaces
o.expandtab = true

-- 4 char tab
o.tabstop = 4
o.softtabstop = 4
o.shiftwidth = 4

-- copy indent from current line when starting a new line
o.autoindent = true

-- searching
o.ignorecase = true
o.smartcase = true
o.incsearch = true
o.hlsearch = true

-- avoid most of the 'Hit Enter ...' messages
o.shortmess = "aoOtTI"

-- no backup, no swaps = cleaner
o.backup = false
o.writebackup = false
o.swapfile = false

-- persistent undos
o.undofile = true

o.laststatus = 0

-- stop complaints about switching buffer with changes
o.hidden = true

-- center the cursor while scrolling
o.scrolloff = 8

o.updatetime = 100
o.timeoutlen = 500

-- no cluttering
o.signcolumn = "no"

-- faster escapes
o.ttimeoutlen = 0

-- stop vim from silently messing with files that it shouldn't
o.fixendofline = true

-- better ascii friendly listchars
o.listchars = {
    space = "*",
    trail = "*",
    nbsp = "*",
    extends = ">",
    precedes = "<",
    tab = "|>",
}

-- command history
o.history = 100

-- ruler format
o.ruf = "%60(%=%#LineNr#%.50F [%{strlen(&ft)?&ft:'none'}] %l:%c %p%%%)"

-- sync clipboard between OS and Neovim
o.clipboard:append('unnamedplus')

-- 24 bit color support
o.termguicolors = true

o.background = "light"
