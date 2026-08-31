return {
  'nickjvandyke/opencode.nvim',
  version = '*', -- Latest stable release
  config = function()
    ---@type opencode.Opts
    vim.g.opencode_opts = {
      -- Your configuration, if any; goto definition on the type for details
    }

    vim.keymap.set({ 'n', 'x' }, '<leader>aa', function()
      require('opencode').ask '@this: '
    end, { desc = 'Ask OpenCode…' })
    vim.keymap.set({ 'n', 'x' }, '<leader>as', function()
      require('opencode').select()
    end, { desc = 'Select OpenCode…' })
    vim.keymap.set({ 'n', 'x' }, '<leader>ar', function()
      return require('opencode').operator '@this '
    end, { desc = 'Append range to OpenCode', expr = true })
    vim.keymap.set({ 'n' }, '<leader>ap', function()
      return require('opencode').operator '@this ' .. '_'
    end, { desc = 'Append line to OpenCode', expr = true })
    vim.keymap.set({ 'n' }, '<S-M-u>', function()
      require('opencode').command 'session.half.page.up'
    end, { desc = 'Scroll OpenCode up' })
    vim.keymap.set({ 'n' }, '<S-M-d>', function()
      require('opencode').command 'session.half.page.down'
    end, { desc = 'Scroll OpenCode down' })
  end,
}
