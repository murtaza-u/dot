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
    nmap('<leader>k', vim.lsp.buf.signature_help)
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
    clangd = 'clangd',
    html = 'vscode-html-language-server',
    cssls = 'vscode-css-language-server',
    ts_ls = 'typescript-language-server',
    templ = 'templ',
    nixd = 'nixd',
    terraformls = 'terraform-ls',
    tflint = 'tflint',
    ols = 'ols',
}
for lsp, bin in pairs(servers) do
    if vim.fn.executable(bin) == 1 then
        lspconfig[lsp].setup({
            on_attach = on_attach,
            capabilities = capabilities,
        })
    end
end

-- terraform
-- if vim.fn.executable('terraform-ls') == 1 then
--     lspconfig.terraformls.setup{
--         on_attach = on_attach,
--         capabilities = capabilities,
--         filetypes = { "tf", "terraform", "terraform-vars" },
--     }
-- end

-- tflint
-- if vim.fn.executable('tflint') == 1 then
--     lspconfig.tflint.setup{
--         on_attach = on_attach,
--         capabilities = capabilities,
--         filetypes = { "tf", "terraform", "terraform-vars" },
--     }
-- end

-- go
if vim.fn.executable('gopls') == 1 then
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
    vim.api.nvim_create_autocmd("BufWritePre", {
        pattern = "*.go",
        callback = function()
            local params = vim.lsp.util.make_range_params()
            params.context = {only = {"source.organizeImports"}}
            -- buf_request_sync defaults to a 1000ms timeout. Depending on your
            -- machine and codebase, you may want longer. Add an additional
            -- argument after params if you find that you have to write the
            -- file twice for changes to be saved.
            -- E.g., vim.lsp.buf_request_sync(0, "textDocument/codeAction", params, 3000)
            local result = vim.lsp.buf_request_sync(0, "textDocument/codeAction", params)
            for cid, res in pairs(result or {}) do
                for _, r in pairs(res.result or {}) do
                    if r.edit then
                        local enc = (vim.lsp.get_client_by_id(cid) or {}).offset_encoding or "utf-16"
                        vim.lsp.util.apply_workspace_edit(r.edit, enc)
                    end
                end
            end
            vim.lsp.buf.format({async = false})
        end
    })
end

-- emmet
if vim.fn.executable('emmet-language-server') == 1 then
    lspconfig.emmet_language_server.setup{
        on_attach = on_attach,
        capabilities = capabilities,
        filetypes = { "html", "templ" },
    }
end

-- tailwind
if vim.fn.executable('tailwindcss-language-server') == 1 then
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
end

-- yaml
if vim.fn.executable('yaml-language-server') == 1 then
    lspconfig.yamlls.setup {
        settings = {
            yaml = {
                schemas = {
                    ["https://json.schemastore.org/github-workflow.json"] = "/.github/workflows/*",
                },
            },
        }
    }
end
