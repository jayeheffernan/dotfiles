vim.treesitter.language.register('markdown', 'octo')

return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        -- NB: I foun this tricky to get installed properly. This worked:
        -- Run a debug config for typescript
        -- Open and switch into the REPL
        -- THEN run :TSInstall dap_repl
        "dap_repl",
        "bash",
        "css",
        "csv",
        "git_config",
        "git_rebase",
        "gitcommit",
        "gitignore",
        "graphql",
        "html",
        "http",
        "hurl",
        "javascript",
        "json",
        "lua",
        "make",
        "markdown",
        "python",
        "rust",
        "scss",
        "sql",
        "tmux",
        "tsv",
        "tsx",
        "typescript",
        "yaml",
      },
      incremental_selection = {
        enable = false,
      }
    },
  },
  {
    'nvim-treesitter/nvim-treesitter-context',
    config = function()
      require('treesitter-context').setup({
        enable = true,            -- Enable this plugin (Can be enabled/disabled later via commands)
        max_lines = 8,            -- How many lines the window should span. Values <= 0 mean no limit.
        min_window_height = 0,    -- Minimum editor window height to enable context. Values <= 0 mean no limit.
        line_numbers = true,
        multiline_threshold = 20, -- Maximum number of lines to collapse for a single context line
        trim_scope = 'outer',     -- Which context lines to discard if `max_lines` is exceeded. Choices: 'inner', 'outer'
        mode = 'cursor',          -- Line used to calculate context. Choices: 'cursor', 'topline'
        -- Separator between context and content. Should be a single character string, like '-'.
        -- When separator is set, the context will only show up when there are at least 2 lines above cursorline.
        separator = '-',
        zindex = 20,     -- The Z-index of the context window
        on_attach = nil, -- (fun(buf: integer): boolean) return false to disable attaching
      })
    end
  }
}
