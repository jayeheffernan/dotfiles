local keymap = vim.keymap.set

return {
  {
    "anuvyklack/hydra.nvim",
    config = function()
      local Hydra = require('hydra')
      Hydra({
        name = "quickfix",
        mode = 'n',
        body = '<leader>v',
        heads = {
          { 'j', ':cnext<Enter>',  { desc = "next", silent = true } },
          { 'k', ':cprev<Enter>',  { desc = "prev", silent = true } },
          { 'h', ':cfirst<Enter>', { desc = "first", silent = true } },
          { 'l', ':clast<Enter>',  { desc = "last", silent = true } },
        }
      })
    end
  },
}
