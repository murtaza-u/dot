-- set <space> as the leader key
-- NOTE: Must happen before plugins are loaded (otherwise wrong leader will be used)
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

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
