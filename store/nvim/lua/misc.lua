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
