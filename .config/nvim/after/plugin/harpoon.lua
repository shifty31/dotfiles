local mark = require("harpoon.mark")
local ui = require("harpoon.ui")


vim.keymap.set("n", "mm", mark.toggle_file)
vim.keymap.set("n", "<C-e>", ui.toggle_quick_menu)

vim.keymap.set("n", "ma", function() ui.nav_file(1) end)
vim.keymap.set("n", "ms", function() ui.nav_file(2) end)
vim.keymap.set("n", "md", function() ui.nav_file(3) end)
vim.keymap.set("n", "mf", function() ui.nav_file(4) end)
vim.keymap.set("n", "mg", function() ui.nav_file(5) end)
