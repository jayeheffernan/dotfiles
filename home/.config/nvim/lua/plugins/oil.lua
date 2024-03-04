local show_hidden = false;
local default_columns = {
  "icon",
};
return {
  {
    "stevearc/oil.nvim",
    opts = {
      columns = default_columns,
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
        ["~"] = {
          desc = "Toggle detail view",
          callback = function()
            local oil = require("oil")
            local config = require("oil.config")
            oil.toggle_hidden();
            if #config.columns == #default_columns then
              oil.set_columns({ "permissions", "size", "mtime", "icon", })
            else
              oil.set_columns(default_columns)
            end
          end,
        },
      },
      use_default_keymaps = false,
    },
    -- Optional dependencies
    dependencies = { "nvim-tree/nvim-web-devicons" },
  },
}
