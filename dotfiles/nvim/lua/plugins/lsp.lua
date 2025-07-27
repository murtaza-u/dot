return {
    {
        -- `lazydev` configures Lua LSP for your Neovim config, runtime and plugins
        -- used for completion, annotations and signatures of Neovim apis
        'folke/lazydev.nvim',
        ft = 'lua',
        opts = {
            library = {
                -- Load luvit types when the `vim.uv` word is found
                { path = '${3rd}/luv/library', words = { 'vim%.uv' } },
            },
        },
    },
    {
        "neovim/nvim-lspconfig",
        dependencies = {
            -- provides support for additional completion capabilities
            "hrsh7th/nvim-cmp",
            -- "saghen/blink.cmp",
        },
        config = function()
            vim.diagnostic.config({
                severity_sort = true,
                virtual_text = true,
            })

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

            local caps = vim.lsp.protocol.make_client_capabilities()
            caps = require('cmp_nvim_lsp').default_capabilities(caps)
            -- caps = require('blink.cmp').get_lsp_capabilities(caps)

            local servers = {
                lua_ls = {
                    binary = "lua-language-server",
                    settings = {
                        Lua = {
                            completion = {
                                callSnippet = 'Replace',
                            },
                            diagnostics = { disable = { 'missing-fields' } },
                        },
                    },
                },
                gopls = {
                    binary = "gopls",
                    settings = {
                        gopls = {
                            staticcheck = true,
                            gofumpt = true,
                        },
                    },
                },
                clangd = { binary = 'clangd' },
                html = { binary = 'vscode-html-language-server' },
                cssls = { binary = 'vscode-css-language-server' },
                ts_ls = { binary = 'typescript-language-server' },
                templ = { binary = 'templ' },
                nixd = { binary = 'nixd' },
                emmet_language_server = {
                    binary = 'emmet-language-server',
                    filetypes = { "html", "templ" },
                },
                tailwindcss = {
                    binary = 'tailwindcss-language-server',
                    filetypes = {
                        'html',
                        'templ',
                    },
                    init_options = {
                        userLanguages = {
                            templ = "html",
                        }
                    }
                },
                yamlls = {
                    binary = 'yaml-language-server',
                    settings = {
                        yaml = {
                            schemas = {
                                ["https://json.schemastore.org/github-workflow.json"] = "/.github/workflows/*",
                            },
                        },
                    }
                },
                terraformls = {
                    binary = 'terraform-ls',
                },
                tflint = {
                    binary = 'tflint',
                },
                pyright = {
                    binary = 'pyright',
                },
            }

            local lspconfig = require("lspconfig")

            for lsp, config in pairs(servers) do
                if config.binary ~= nil or config.binary ~= "" then
                    if vim.fn.executable(config.binary) == 1 then
                        config.binary = nil
                        config.on_attach = on_attach
                        config.capabilities = caps
                        lspconfig[lsp].setup(config)
                    end
                end
            end
        end,
    },
}
