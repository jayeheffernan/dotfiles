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
        "bash",
        "css",
        "dom",
        "express",
        "eslint", "prettier",
        "svg",
        "git",
        "http",
        "javascript",
        "html", "jest", "typescript", "docker",
        "jsdoc",
        "lodash-4",
        "lua-5.4",
        "moment",
        "moment_timezone",
        "node-18_lts",
        "postgresql-11",
        "react",
        "redis",
        "sass",
        "web_extensions",
        "webpack-4",
        "webpack-5",
      }
    }
  }
}
