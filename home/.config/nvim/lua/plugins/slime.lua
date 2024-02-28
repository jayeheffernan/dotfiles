return {
  {
    "jpalardy/vim-slime",
    init = function()
      vim.g.slime_target = "tmux"
      vim.g.slime_no_mappings = 1
      vim.keymap.set("x", "<leader>rs", "<Plug>SlimeRegionSend");
      vim.keymap.set("n", "<leader>rs", "<Plug>SlimeParagraphSend");
      vim.keymap.set("n", "<leader>rS", "<Plug>SlimeConfig");
    end
  },
}
