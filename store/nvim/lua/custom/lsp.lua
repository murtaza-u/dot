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

-- Use LspAttach autocommand to only map the following keys after the
-- language server attaches to the current buffer
vim.api.nvim_create_autocmd('LspAttach', {
    group = vim.api.nvim_create_augroup('UserLspConfig', {}),
    callback = function(ev)
        -- Enable completion triggered by <c-x><c-o>
        vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

        -- Buffer local mappings.
        -- See `:help vim.lsp.*` for documentation on any of the below
        -- functions
        local opts = { buffer = ev.buf }
        local map = vim.keymap.set

        map('n', 'gD', vim.lsp.buf.declaration, opts)
        map('n', 'gd', vim.lsp.buf.definition, opts)
        map('n', 'gi', vim.lsp.buf.implementation, opts)
        map('n', 'gr', vim.lsp.buf.references, opts)
        map('n', 'K', vim.lsp.buf.hover, opts)
        -- map('n', '<C-k>', vim.lsp.buf.signature_help, opts)
        map('n', '<leader>ir', vim.lsp.buf.rename, opts)
        map({ 'n', 'v' }, '<leader>a', vim.lsp.buf.code_action, opts)
        map('n', '<leader>=', function()
            vim.lsp.buf.format { async = true }
        end, opts)
    end,
})

-- go
vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*.go",
  callback = function()
    local params = vim.lsp.util.make_range_params()
    params.context = {only = {"source.organizeImports"}}
    -- buf_request_sync defaults to a 1000ms timeout. Depending on your machine
    -- and codebase, you may want longer. Add an additional argument after
    -- params if you find that you have to write the file twice for changes to
    -- be saved.
    -- E.g:
    -- vim.lsp.buf_request_sync(0, "textDocument/codeAction", params, 3000)
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

local cap = vim.lsp.protocol.make_client_capabilities()
cap.textDocument.completion.completionItem = {
    documentationFormat = { "markdown", "plaintext" },
    snippetSupport = true,
    preselectSupport = true,
    insertReplaceSupport = true,
    labelDetailsSupport = true,
    deprecatedSupport = true,
    commitCharactersSupport = true,
    tagSupport = { valueSet = { 1 } },
    resolveSupport = {
        properties = {
            "documentation",
            "detail",
            "additionalTextEdits",
        },
    },
}

local lspconfig = require("lspconfig")

lspconfig.clangd.setup{ capabilities = cap }
lspconfig.gopls.setup{
    capabilities = cap,
    settings = {
        gopls = {
            staticcheck = true,
            gofumpt = true,
        },
    },
}
lspconfig.html.setup{ capabilities = cap }
lspconfig.cssls.setup{ capabilities = cap }
lspconfig.tsserver.setup{ capabilities = cap }
lspconfig.emmet_language_server.setup{
    capabilities = cap,
    filetypes = { "html", "svelte", "templ" },
}
lspconfig.tailwindcss.setup{
    filetypes = {
        'templ',
        'html',
        'svelte'
        -- include any other filetypes where you need tailwindcss
    },
    init_options = {
        userLanguages = {
            templ = "html",
        }
    }
}
lspconfig.templ.setup{ capabilities = cap }
lspconfig.nixd.setup{ capabilities = cap }
lspconfig.zls.setup{
    capabilities = cap,
    cmd = { os.getenv("HOME") .. "/.zig/zls" },
    settings = {
        -- Further information on ZLS config options:
        -- https://github.com/zigtools/zls#configuration-options
        zls = {
            zig_exe_path =  os.getenv("HOME") .. "/.zig/zig",
        },
    },
}
