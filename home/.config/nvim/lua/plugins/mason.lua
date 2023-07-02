return {
  {

    "williamboman/mason.nvim",
    opts = {
      ensure_installed = {
        "stylua",
        "shfmt",
        "docker-compose-language-service",
        "dockerfile-language-server",
        "markdownlint",
        "sqlls",
        "sqlfluff",
        "marksman",
      },
    },
  },
}
