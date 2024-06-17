local o = vim.opt

o.compatible = false

-- faster scrolling
o.ttyfast = true

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

-- o.textwidth = 72

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
o.undodir = "/tmp/nvim/undodir"
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
o.ttimeout = true
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
o.ruf = "%30(%=%#LineNr#%.50F [%{strlen(&ft)?&ft:'none'}] %l:%c %p%%%)"

-- sync clipboard between OS and Neovim
o.clipboard:append('unnamedplus')

-- 24 bit color support
-- o.termguicolors = true

-- map leader key to <SPC>
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- disable builtin plugins
vim.g.loaded_netrw = true
vim.g.loaded_netrwPlugin = true
vim.g.loaded_netrwSettings = true
vim.g.loaded_netrwFileHandlers = true
vim.g.loaded_gzip = true
vim.g.loaded_zip = true
vim.g.loaded_zipPlugin = true
vim.g.loaded_tar = true
vim.g.loaded_tarPlugin = true
vim.g.loaded_getscript = true
vim.g.loaded_getscriptPlugin = true
vim.g.loaded_vimball = true
vim.g.loaded_vimballPlugin = true
vim.g.loaded_2html_plugin = true
vim.g.loaded_logipat = true
vim.g.loaded_rrhelper = true
vim.g.loaded_spellfile_plugin = true
vim.g.loaded_matchit = true

-- mark trailing spaces
vim.cmd([[match IncSearch '\s\+$']])

-- keymaps
local keymap = vim.keymap
local opts = { noremap = true, silent = true }

keymap.set("n", "<C-q>", function()
    local qf_exists = false
    for _, win in pairs(vim.fn.getwininfo()) do
        if win["quickfix"] == 1 then
            qf_exists = true
        end
    end
    if qf_exists == true then
        vim.cmd "cclose"
        return
    end
    if not vim.tbl_isempty(vim.fn.getqflist()) then
        vim.cmd "copen"
    end
end, opts)

-- moving text
keymap.set("v", "J", ":m '>+1<CR>gv=gv", opts)
keymap.set("v", "K", ":m '<-2<CR>gv=gv", opts)

-- better tabbing
keymap.set("v", "<", "<gv", opts)
keymap.set("v", ">", ">gv", opts)

-- buffer switching
keymap.set("n", "<leader>n", ":bnext<CR>", opts)
keymap.set("n", "<leader>p", ":bprev<CR>", opts)

-- keep jumping
keymap.set("n", "{", ":keepjumps normal! {<CR>", opts)
keymap.set("n", "}", ":keepjumps normal! }<CR>", opts)

-- undo break point
keymap.set("i", ",", ",<C-g>U", opts)
keymap.set("i", ".", ".<C-g>U", opts)
keymap.set("i", "!", "!<C-g>U", opts)
keymap.set("i", "?", "?<C-g>U", opts)

-- quickfix list navigation
keymap.set("n", "<C-j>", ":cnext<CR>", opts)
keymap.set("n", "<C-k>", ":cprev<CR>", opts)

-- keeping it centered
keymap.set("n", "n", "nzzzv", opts)
keymap.set("n", "N", "Nzzzv", opts)

-- toggle line numbers
keymap.set("n", "<leader>l", ":set nu! rnu!<CR>", opts)

local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

autocmd('TextYankPost', {
    group = augroup('HighlightYank', {}),
    pattern = '*',
    callback = function()
        vim.highlight.on_yank({
            higroup = 'IncSearch',
            timeout = 40,
        })
    end,
})

autocmd({"BufWritePre"}, {
    group = augroup('TrimLeadingSpace', {}),
    pattern = "*",
    command = [[%s/\s\+$//e]],
})

autocmd({"BufReadPost"}, {
    group = augroup('RememberLastPosition', {}),
    pattern = "*",
    command = 'silent! normal! g`"zv',
})

-- additional filetypes
vim.filetype.add({
    extension = {
        templ = "templ",
    },
})

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

local plugins = require("plugins")
require("lazy").setup(plugins)
