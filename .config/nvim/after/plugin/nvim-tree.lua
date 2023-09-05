-- set termguicolors to enable highlight groups
vim.opt.termguicolors = true

require("nvim-tree").setup({
    sort_by = "case_sensitive",
    hijack_netrw = false,
    view = {
        width = 30,
        mappings = {
            list = {
                { key = "u", action = "dir_up" },
                { key = "w", action = "cd" },
            },
        },
    },
    renderer = {
        group_empty = true,
    },
    filters = {
        dotfiles = true,
    },
})

local opts = { noremap = true, silent = true }

local api = require("nvim-tree")

local function toggleFocus()
    local utils = require("nvim-tree.utils")
    -- is either closed or not focused
    local is_tree_buf = utils.is_nvim_tree_buf()

    if is_tree_buf then
        api.toggle()
    else
        api.focus()
    end
end

-- vim.keymap.set("n", "<leader>mn", tree.marks.navigate.next)
-- vim.keymap.set("n", "<leader>mp", tree.marks.navigate.prev)
-- vim.keymap.set("n", "<leader>ms", tree.marks.navigate.select)
vim.keymap.set("n", "<leader>e", toggleFocus, opts)
