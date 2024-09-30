local lspconfig = require("lspconfig")

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

local function on_attach(_, bufnr)
    local nmap = function(keys, func)
        vim.keymap.set('n', keys, func, { buffer = bufnr })
    end

    nmap('gD', vim.lsp.buf.declaration)
    nmap('gd', vim.lsp.buf.definition)
    nmap('gi', vim.lsp.buf.implementation)
    nmap('gr', vim.lsp.buf.references)
    nmap('K', vim.lsp.buf.hover)
    nmap('<C-k>', vim.lsp.buf.signature_help)
    nmap('<leader>ir', vim.lsp.buf.rename)
    nmap('<leader>a', vim.lsp.buf.code_action)

    -- Create a command `:Format` local to the LSP buffer
    vim.api.nvim_buf_create_user_command(bufnr, 'Format', function(_)
        if vim.lsp.buf.format then
            vim.lsp.buf.format()
        elseif vim.lsp.buf.formatting then
            vim.lsp.buf.formatting()
        end
    end, { desc = 'Format current buffer with LSP' })
end

-- nvim-cmp supports additional completion capabilities
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

-- language servers that do not require additional configuration
local servers = {
    'clangd',
    'html',
    'cssls',
    'ts_ls',
    'templ',
    'nixd',
}
for _, lsp in ipairs(servers) do
    lspconfig[lsp].setup({
        on_attach = on_attach,
        capabilities = capabilities,
    })
end

-- go
lspconfig.gopls.setup{
    on_attach = on_attach,
    capabilities = capabilities,
    settings = {
        gopls = {
            staticcheck = true,
            gofumpt = true,
        },
    },
}

-- emmet
lspconfig.emmet_language_server.setup{
    on_attach = on_attach,
    capabilities = capabilities,
    filetypes = { "html", "templ" },
}

-- tailwind
lspconfig.tailwindcss.setup{
    on_attach = on_attach,
    capabilities = capabilities,
    filetypes = {
        'html',
        'templ',
        -- include any other filetypes where you need tailwindcss
    },
    init_options = {
        userLanguages = {
            templ = "html",
        }
    }
}

-- yaml
lspconfig.yamlls.setup {
    settings = {
        yaml = {
            schemas = {
                ["https://json.schemastore.org/github-workflow.json"] = "/.github/workflows/*",
            },
        },
    }
}
