return {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    dependencies = {
        'nvim-treesitter/nvim-treesitter-textobjects',
        'vrischmann/tree-sitter-templ',
    },
    config = function()
        require('nvim-treesitter.configs').setup({
            ensure_installed = {
                'go',
                'gomod',
                'gosum',
                'gowork',
                'gotmpl',
                'templ',
                'lua',
                'sql',
                'terraform',
                'html',
                'css',
                'javascript',
                'typescript',
                'json',
                'nix',
                'markdown',
                'markdown_inline',
            },
            highlight = {
                enable = true,
                -- Some languages depend on vim's regex highlighting system for
                -- indent rules.
                --
                -- If you are experiencing weird indenting issues, add the
                -- language to the list of additional_vim_regex_highlighting
                -- and disabled languages for indent.
                additional_vim_regex_highlighting = { 'markdown' },
                disable = { "just" },
            },
            indent = {
                enable = true,
                disable = { "markdown" },
            },
            incremental_selection = {
                enable = true,
                keymaps = {
                    init_selection = '<leader>i',
                    node_incremental = '<leader>i',
                    node_decremental = '<leader>o',
                },
            },
            textobjects = {
                select = {
                    enable = true,
                    lookahead = true, -- automatically jump forward to textobj
                    keymaps = {
                        -- you can use the capture groups defined in textobjects.scm
                        ['aa'] = '@parameter.outer',
                        ['ia'] = '@parameter.inner',
                        ['af'] = '@function.outer',
                        ['if'] = '@function.inner',
                        ['ac'] = '@class.outer',
                        ['ic'] = '@class.inner',
                        ['ii'] = '@conditional.inner',
                        ['ai'] = '@conditional.outer',
                        ['il'] = '@loop.inner',
                        ['al'] = '@loop.outer',
                        ['at'] = '@comment.outer',
                    },
                },
                move = {
                    enable = true,
                    set_jumps = true, -- whether to set jumps in the jumplist
                    goto_next_start = {
                        [']f'] = '@function.outer',
                        [']]'] = '@class.outer',
                    },
                    goto_next_end = {
                        [']F'] = '@function.outer',
                        [']['] = '@class.outer',
                    },
                    goto_previous_start = {
                        ['[f'] = '@function.outer',
                        ['[['] = '@class.outer',
                    },
                    goto_previous_end = {
                        ['[F'] = '@function.outer',
                        ['[]'] = '@class.outer',
                    },
                },
                swap = {
                    enable = true,
                    swap_next = {
                        ['<leader>a'] = '@parameter.inner',
                    },
                    swap_previous = {
                        ['<leader>A'] = '@parameter.inner',
                    },
                },
            },
        })
    end,
}
