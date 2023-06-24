-- suppress error messages from lang servers
vim.notify = function(msg, log_level, _)
    if msg:match("exit code") then
        return
    end

    if log_level == vim.log.levels.ERROR then
        vim.api.nvim_err_writeln(msg)
    else
        vim.api.nvim_echo({{msg}}, true, {})
    end
end

-- keymaps
local map = vim.keymap.set
local opts = {noremap = true, silent = true}

map('n', 'gd',         '<cmd>lua vim.lsp.buf.definition()<CR>',      opts)
map('n', 'gD',         '<cmd>lua vim.lsp.buf.declaration()<CR>',     opts)
map('n', 'gi',         '<cmd>lua vim.lsp.buf.implementation()<CR>',  opts)
map('n', 'gr',         '<cmd>lua vim.lsp.buf.references()<CR>',      opts)
map('n', 'gt',         '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
map('n', 'K',          '<cmd>lua vim.lsp.buf.hover()<CR>',           opts)
map('n', 'gs',         '<cmd>lua vim.lsp.buf.signature_help()<CR>',  opts)
map('n', '<leader>a',  '<cmd>lua vim.lsp.buf.code_action()<CR>',     opts)
map('n', '<leader>=',  '<cmd>lua vim.lsp.buf.formatting()<CR>',      opts)
map('n', '<leader>ir', '<cmd>lua vim.lsp.buf.rename()<CR>',          opts)

local cap = vim.lsp.protocol.make_client_capabilities()
cap.textDocument.completion.completionItem.snippetSupport = true
require'lspconfig'.gopls.setup { capabilities = cap }
require'lspconfig'.cssls.setup{ capabilities = cap }
require'lspconfig'.tsserver.setup{ capabilities = cap }
