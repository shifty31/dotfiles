require("ginodev")

-- allow highlight on yank
vim.cmd("au TextYankPost * silent! lua vim.highlight.on_yank()")
-- vim.highlight.on_yank()
