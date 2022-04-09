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

-- LSP Diagnostics
vim.fn.sign_define(
    "LspDiagnosticsSignError",
    {texthl = "LspDiagnosticsSignError", text = " ", numhl = "LspDiagnosticsSignError"}
)
vim.fn.sign_define(
    "LspDiagnosticsSignWarning",
    {texthl = "LspDiagnosticsSignWarning", text = " ", numhl = "LspDiagnosticsSignWarning"}
)
vim.fn.sign_define(
    "LspDiagnosticsSignInformation",
    {texthl = "LspDiagnosticsSignInformation", text = "", numhl = "LspDiagnosticsSignInformation"}
)
vim.fn.sign_define(
    "LspDiagnosticsSignHint",
    {texthl = "LspDiagnosticsSignHint", text = "", numhl = "LspDiagnosticsSignHint"}
)

local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())
capabilities.textDocument.completion.completionItem.snippetSupport = true

require'lspconfig'.clangd.setup {
    capabilities = capabilities,
}

require'lspconfig'.gopls.setup {
    capabilities = capabilities,
}

require'lspconfig'.cssls.setup {
    capabilities = capabilities,
}

require'lspconfig'.tsserver.setup{
    capabilities = capabilities,
}

local map = vim.api.nvim_set_keymap
local props = {noremap = true, silent = true}

map('n', 'gd',         '<cmd>lua vim.lsp.buf.definition()<CR>',      props)
map('n', 'gD',         '<cmd>lua vim.lsp.buf.declaration()<CR>',     props)
map('n', 'gi',         '<cmd>lua vim.lsp.buf.implementation()<CR>',  props)
map('n', 'gr',         '<cmd>lua vim.lsp.buf.references()<CR>',      props)
map('n', 'gt',         '<cmd>lua vim.lsp.buf.type_definition()<CR>', props)
map('n', 'K',          '<cmd>lua vim.lsp.buf.hover()<CR>',           props)
map('n', 'gs',         '<cmd>lua vim.lsp.buf.signature_help()<CR>',  props)
map('n', '<leader>a',  '<cmd>lua vim.lsp.buf.code_action()<CR>',     props)
map('n', '<leader>=',  '<cmd>lua vim.lsp.buf.formatting()<CR>',      props)
map('n', '<leader>ir', '<cmd>lua vim.lsp.buf.rename()<CR>',          props)

-- map('n', '<leader>gw', '<cmd>lua vim.lsp.buf.document_symbol()<CR>', props)
-- map('n', '<leader>gW', '<cmd>lua vim.lsp.buf.workspace_symbol()<CR>', props)
-- map('n', '<leader>ee', '<cmd>lua vim.lsp.util.show_line_diagnostics()<CR>', props)
-- map('n', '<leader>ai', '<cmd>lua vim.lsp.buf.incoming_calls()<CR>', props)
-- map('n', '<leader>ao', '<cmd>lua vim.lsp.buf.outgoing_calls()<CR>', props)
