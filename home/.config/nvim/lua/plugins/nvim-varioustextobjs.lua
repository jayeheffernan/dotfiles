return {
  -- lazy.nvim
  -- {
  --   enabled = false,
  --   "chrisgrieser/nvim-various-textobjs",
  --   lazy = false,
  --   config = function()
  --     require("various-textobjs").setup({ useDefaultKeymaps = true })
  --   end
  -- },
  { "kana/vim-textobj-entire", dependencies = { "kana/vim-textobj-user" } }
}
