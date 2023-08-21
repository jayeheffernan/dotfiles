return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        -- NB: I foun this tricky to get installed properly. This worked:
        -- Run a debug config for typescript
        -- Open and switch into the REPL
        -- THEN run :TSInstall dap_repl
        "dap_repl"
      },
    },
  },
}
