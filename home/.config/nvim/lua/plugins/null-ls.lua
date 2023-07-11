return {
  {
    enabled = false,
    "jose-elias-alvarez/null-ls.nvim",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = { "mason.nvim" },
    opts = function(_, opts)
      local nls = require("null-ls")
      -- -use this to extend instead
      -- vim.list_extend(opts.sources, { ...
      opts.sources = {
        -- Prettierd is faster
        nls.builtins.formatting.prettierd.with({
          filetypes = {
            "javascript",
            "javascriptreact",
            "typescript",
            "typescriptreact",
            "vue",
            "css",
            "scss",
            "less",
            "html",
            "json",
            "jsonc",
            "yaml",
          },
          timeout = 8000,
        }),
        -- Prettierd seems to truncate my long markdown files often
        nls.builtins.formatting.prettier.with({
          filetypes = { "markdown", "markdown.mdx" },
          timeout = 8000,
        }),
        nls.builtins.formatting.eslint_d.with({
          timeout = 8000,
        }),
        nls.builtins.diagnostics.sqlfluff,
        -- Both formatters will run, in the order they're registered
        nls.builtins.formatting.pg_format,
        nls.builtins.formatting.sqlfluff,
        nls.builtins.code_actions.refactoring,
      }
      return opts
    end,
  },
}
