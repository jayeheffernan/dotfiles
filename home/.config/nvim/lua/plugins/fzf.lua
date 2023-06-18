return {
  { "junegunn/fzf" },
  { "junegunn/fzf.vim" },
  {
    "telescope.nvim",
    dependencies = {
      "nvim-telescope/telescope-fzf-native.nvim",
      build = "make",
      config = function()
        require("telescope").load_extension("fzf")
      end,
    },
  },
  { "gfanto/fzf-lsp.nvim" },
}
