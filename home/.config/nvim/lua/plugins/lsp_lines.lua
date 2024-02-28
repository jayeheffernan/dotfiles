local keymap = vim.keymap.set;

local vt = false;
local toggle = function()
  vim.diagnostic.config({ virtual_lines = not vt })
  vim.diagnostic.config({ virtual_text = vt, })
  vt = not vt
end

return {
  {
    "https://git.sr.ht/~whynothugo/lsp_lines.nvim",

    as = 'lsp_lines.nvim',

    dependencies = {
      "neovim/nvim-lspconfig"
    },

    config = function()
      require("lsp_lines").setup()
      vim.diagnostic.config({ virtual_lines = false })
      keymap("n", "<leader>ud", toggle, { desc = "Toggle diagnostics mode" })
    end,
  }
}
