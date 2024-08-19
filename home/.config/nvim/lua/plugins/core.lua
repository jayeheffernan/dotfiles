return {
  { "catppuccin/nvim", priority = 100 },
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = function()
        require("catppuccin").load()
        vim.cmd('highlight Normal guibg=NONE ctermbg=NONE')
        vim.cmd('highlight NormalNC guibg=NONE ctermbg=NONE')
        vim.cmd('highlight NormalSB guibg=NONE ctermbg=NONE')
        vim.cmd('highlight NormalFloat guibg=black ctermbg=black')
      end,
      defaults = {
        keymaps = false,
      },
    },
  },
}
