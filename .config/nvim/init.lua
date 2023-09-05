require("ginodev")

-- disable netrw at the very start of your init.lua (strongly advised)
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- allow highlight on yank
vim.cmd("au TextYankPost * silent! lua vim.highlight.on_yank()")
-- vim.highlight.on_yank()
