return function (trunc_req)
    local color = '%#StatuslineFilename#'
    local file_name, file_ext = vim.fn.expand('%:t'), vim.fn.expand('%:e')
    local icon = require('nvim-web-devicons').get_icon(file_name, file_ext, {default = true})
    if not trunc_req then
        local trunc_home = require('statusline.trunc_home')
        local relative_path = require('statusline.relative_path')
        file_name = trunc_home(relative_path(vim.fn.expand("%f")))
    end

    if vim.api.nvim_buf_get_option(0, "modified") then
        file_name = file_name .. "[+]"
    end

    return string.format("%s %s %s", color, icon, file_name)
end
