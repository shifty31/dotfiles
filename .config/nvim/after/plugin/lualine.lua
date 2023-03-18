local ignoreFocus = {'NvimTree', 'TelescopePrompt' }
local extensions = {'nvim-tree', 'quickfix'}

require('lualine').setup({
    options = {
        theme = 'modus-vivendi',
        globalstatus = true,
        ignore_focus = ignoreFocus,
        extensions = extensions,
    },
      sections = {
        lualine_a = {'mode'},
        lualine_b = {'branch', 'diff'},
        lualine_c = {'filename'},
        lualine_x = {{'diagnostics', sources = {'nvim_lsp'}}},
        lualine_y = {'progress'},
        lualine_z = {'location'}
  },
})
