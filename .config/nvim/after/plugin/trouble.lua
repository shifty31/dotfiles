local actions = require("telescope.actions")
local trouble = require("trouble.providers.telescope")

local opts = { silent = true, noremap = true }

vim.keymap.set("n", "<leader>dq", "<cmd>TroubleToggle quickfix<cr>", opts)
vim.keymap.set("n", "<leader>dt", "<cmd>TroubleToggle<cr>", opts)

local telescope = require("telescope")

telescope.setup {
    defaults = {
        mappings = {
            i = { ["<c-t>"] = trouble.open_with_trouble },
            n = { ["<c-t>"] = trouble.open_with_trouble },
        },
    },
}
