return {
  'Wansmer/treesj',
  dependencies = { 'nvim-treesitter/nvim-treesitter' },
  config = function()
    require('treesj').setup({
      use_default_keymaps = false,
      ---@type boolean Node with syntax error will not be formatted
      check_syntax_error = true,
      ---If line after join will be longer than max value,
      ---@type number If line after join will be longer than max value, node will not be formatted
      max_join_length = 4000,
      ---Cursor behavior:
      ---hold - cursor follows the node/place on which it was called
      ---start - cursor jumps to the first symbol of the node being formatted
      ---end - cursor jumps to the last symbol of the node being formatted
      ---@type 'hold'|'start'|'end'
      cursor_behavior = 'hold',
    })
    vim.keymap.set('n', '<leader>tm', function()
      require('treesj').toggle()
    end)
    vim.keymap.set('n', '<leader>tM', function()
      require('treesj').toggle({ split = { recursive = true }, join = { recursive = true } })
    end)
    vim.keymap.set('n', '<leader>ts', function()
      require('treesj').split()
    end)
    vim.keymap.set('n', '<leader>tS', function()
      require('treesj').split({ split = { recursive = true } })
    end)
    vim.keymap.set('n', '<leader>tj', function()
      require('treesj').join()
    end)
    vim.keymap.set('n', '<leader>tJ', function()
      require('treesj').join({ join = { recursive = true } })
    end)
  end,
}
