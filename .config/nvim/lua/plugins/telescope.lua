local wk = require("which-key")
wk.register({
  ["<leader>t"] = { name = "+Telescope" },
})

return {
  {
    "nvim-telescope/telescope-file-browser.nvim",
    dependencies = { "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim" },
  },
  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      "nvim-telescope/telescope-file-browser.nvim",
      config = function()
        require("telescope").load_extension("file_browser")
      end,
    },
    keys = {
      {
        "<leader>fe",
        function()
          require("telescope").extensions.file_browser.file_browser()
        end,
        desc = "File Browser",
      },
      {
        --- disable default find buffer
        "<leader>fb",
        false,
      },
      {
        "<C-e>",
        function()
          require("telescope.builtin").buffers()
        end,
        desc = "Buffer List",
      },
      {
        "<leader>tk",
        function()
          require("telescope.builtin").keymaps()
        end,
        desc = "Keymaps",
      },
    },
    opts = function()
      local actions = require("telescope.actions")

      local opts = {
        pickers = {
          buffers = {
            initial_mode = "normal",
            mappings = {
              n = {
                ["d"] = actions.delete_buffer + actions.move_to_top,
                ["v"] = actions.file_vsplit,
              },
            },
          },
        },
        extensions = {
          file_browser = {
            hijack_netrw = true,
            initial_mode = "normal",
            grouped = true,
            select_buffer = true,
            cwd_to_path = true,
            path = "%:p:h",
          },
        },
      }

      return opts
    end,
  },
}

-- vim.keymap.set('n', '<leader>ff', telescope.find_files, opts)
-- vim.keymap.set('n', '<leader>fg', telescope.git_files, opts)
-- vim.keymap.set('n', '<C-e>', telescope.buffers, opts)
-- vim.keymap.set('n', '<leader>fq', telescope.quickfix, opts)
-- vim.keymap.set('n', '<leader>fh', telescope.help_tags, opts)
-- vim.keymap.set('n', '<leader>fd', telescope.diagnostics, opts)
-- vim.keymap.set('n', '<leader>F', telescope.live_grep, opts)
-- vim.keymap.set('n', '<leader>fo', telescope.oldfiles, opts)
