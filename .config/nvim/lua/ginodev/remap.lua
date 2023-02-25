local opts = { noremap = true, silent = true }

vim.g.mapleader = " "
vim.keymap.set("n", "<leader>e", ":NvimTreeFocus<CR>", opts)
vim.keymap.set("n", "<leader>p", "\"+p", opts)
vim.keymap.set("v", "<leader>p", "\"+p", opts)
vim.keymap.set("n", "<leader>y", "\"+y", opts)
vim.keymap.set("v", "<leader>y", "\"+y", opts)

vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "<C-d>", "<C-d>zz")

--Telescope
local telescope = require('telescope.builtin')

vim.keymap.set('n', '<leader>ff', telescope.find_files, opts)
vim.keymap.set('n', '<leader>fg', telescope.git_files, opts)
vim.keymap.set('n', '<leader>fb', telescope.buffers, opts)
vim.keymap.set('n', '<leader>fq', telescope.quickfix, opts)
vim.keymap.set('n', '<leader>fh', telescope.help_tags, opts)
