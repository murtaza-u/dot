local highlights

vim.o.laststatus = 2

if vim.o.background == "dark" then
    highlights = {
        StatuslineActive = {guibg = "NONE", guifg = "#ebdbb2"},
        StatuslineInactive = {guibg = "NONE", guifg = "#ebdbb2"},
        StatuslineFilename = {guibg = "NONE", guifg = "#d3869b"},
        StatuslineGitBranch = {guibg = "NONE", guifg = "#8ec07c"},
        StatuslineNormalMode = {guifg = "#83a598"},
        StatuslineInsertMode = {guifg = "#fb4934"},
        StatuslineVisualMode = {guifg = "#fabd2f"},
        StatuslineCommandMode = {guifg = "#b8bb26"},
        StatuslineOtherMode = {guifg = "#ebdbb2"},
    }
else
    highlights = {
        StatuslineActive = {guibg = "NONE", guifg = "#3c3836"},
        StatuslineInactive = {guibg = "NONE", guifg = "#3c3836"},
        StatuslineFilename = {guibg = "NONE", guifg = "#8f3f71"},
        StatuslineGitBranch = {guibg = "NONE", guifg = "#427b58"},
        StatuslineNormalMode = {guifg = "#076678"},
        StatuslineInsertMode = {guifg = "#9d0006"},
        StatuslineVisualMode = {guifg = "#b57614"},
        StatuslineCommandMode = {guifg = "#79740e"},
        StatuslineOtherMode = {guifg = "#3c3836"},
    }
end

for group, props in pairs(highlights) do
    local bg = props.guibg ~= nil and "guibg=" .. props.guibg or "guibg=NONE"
    local fg = props.guifg ~= nil and "guifg=" .. props.guifg or "guifg=NONE"
    local style = props.gui ~= nil and "gui=" .. props.style or "gui=NONE"
    vim.cmd("hi " .. group .. " " .. bg .. " " .. " " .. fg .. " " .. style)
end

local trunc_req = require("statusline.trunc_width")
local filetree_icon = " פּ"

local colors = {
    active = "%#StatuslineActive#",
    inactive = "%#StatuslineInactive#",
}

local components = {
    get_filename = require("statusline.filename"),
    get_git_branch = require("statusline.git_branch"),
}

function Set(focus)
    if focus == 'active' then
        local filetype = vim.bo.filetype
        if filetype == 'netrw' or filetype == "NvimTree" then
            return Set('filetree')
        elseif filetype == 'help' then
            return Set('inactive')
        end

        return table.concat({
            "%10",
            trunc_req() and components.get_filename(true) or components.get_filename(false),
            '%=',
            components.get_git_branch(),
            "%20-",
        }, ' ')
    elseif focus == 'filetree' then
        return colors.inactive .. filetree_icon
    else
        return colors.inactive
    end
end

vim.api.nvim_exec([[
augroup Statusline
au!
au WinEnter,BufEnter * setlocal statusline=%!v:lua.Set('active')
au WinLeave,BufLeave * setlocal statusline=%!v:lua.Set('inactive')
augroup END
]], false)
