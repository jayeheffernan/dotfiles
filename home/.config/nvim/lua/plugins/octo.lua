return {
  {
    "pwntester/octo.nvim",
    enabled = false,
    opts = { mappings = {} },
    config = function(_, opts)
      require("octo").setup(opts)
    end,
  },
}
