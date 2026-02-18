return {
  'windwp/nvim-ts-autotag',
  ft = { 'html', 'javascript', 'typescript', 'typescriptreact', 'svelte', 'vue' }, -- autoclose for these filetypes
  config = function()
    require('nvim-ts-autotag').setup {
      opts = {
        enable_close = true, -- Auto close tags
        enable_rename = true, -- Auto rename pairs of tags
        -- ... other options
      },
      -- You can also override individual filetype configs here if needed
    }
  end,
}
