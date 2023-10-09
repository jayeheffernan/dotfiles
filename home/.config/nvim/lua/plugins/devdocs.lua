return {
  {
    "luckasRanarison/nvim-devdocs",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope.nvim",
      "nvim-treesitter/nvim-treesitter",
    },
    opts = {
      ensure_installed = {
        "express",
        "git",
        "javascript",
        "jsdoc",
        "lodash-4",
        "moment",
        "moment_timezone",
        "node-18_lts",
        "postgresql-11",
        "react",
      }
    }
  }
}
