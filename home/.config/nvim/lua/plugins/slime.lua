return {
  {
    "jpalardy/vim-slime",
    init = function()
      vim.g.slime_target = "tmux"
      -- normally I have Vim in pane 0, and the I'll split a second pane (1) to
      -- send commands to
      vim.g.slime_default_config = { socket_name = "default", target_pane = "1" }
      vim.g.slime_dont_ask_default = 1

      vim.g.slime_no_mappings = 1
      vim.keymap.set("x", "<leader>rs", "<Plug>SlimeRegionSend");
      vim.keymap.set("n", "<leader>rs", "<Plug>SlimeParagraphSend");
      vim.keymap.set("n", "<leader>rS", "<Plug>SlimeConfig");
    end
  },
}
