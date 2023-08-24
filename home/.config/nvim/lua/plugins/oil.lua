return {
  {
    "stevearc/oil.nvim",
    opts = {
      columns = {
        "icon",
      },
      skip_confirm_for_simple_edits = true,
      keymaps = {
        ["?"] = "actions.show_help",
        ["<CR>"] = "actions.select",
        ["<C-?>"] = "actions.preview",
        ["q"] = "actions.close",
        ["<C-c>"] = "actions.close",
        ["<C-l>"] = "actions.refresh",
        ["_"] = "actions.open_cwd",
        ["<"] = "actions.parent",
        [">"] = "actions.select",
        ["."] = "actions.cd",
        ["~"] = "actions.toggle_hidden",
      },
      use_default_keymaps = false,
    },
    -- Optional dependencies
    dependencies = { "nvim-tree/nvim-web-devicons" },
  },
}
