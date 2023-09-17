local opts = { noremap = true, silent = true }

vim.g.mapleader = " "
vim.keymap.set("n", "<leader>p", "\"+p", opts)
vim.keymap.set("v", "<leader>p", "\"+p", opts)
vim.keymap.set("n", "<leader>y", "\"+y", opts)
vim.keymap.set("v", "<leader>y", "\"+y", opts)

vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")
vim.keymap.set("n", "<C-u>", "<C-u>zz")

vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

--Telescope
local telescope = require('telescope.builtin')

vim.keymap.set('n', '<leader>ff', telescope.find_files, opts)
vim.keymap.set('n', '<leader>fg', telescope.git_files, opts)
vim.keymap.set('n', '<C-e>', telescope.buffers, opts)
vim.keymap.set('n', '<leader>fq', telescope.quickfix, opts)
vim.keymap.set('n', '<leader>fh', telescope.help_tags, opts)
vim.keymap.set('n', '<leader>fd', telescope.diagnostics, opts)
vim.keymap.set('n', '<leader>F', telescope.live_grep, opts)
vim.keymap.set('n', '<leader>fo', telescope.oldfiles, opts)

vim.keymap.set('n', '<leader>fe', require('telescope').extensions.file_browser.file_browser, opts)

------- nvchad config ------
