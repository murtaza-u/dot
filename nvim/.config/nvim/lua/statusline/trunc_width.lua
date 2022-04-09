return function ()
    local trunc_width = 60
    return trunc_width >= vim.api.nvim_win_get_width(0)
end
