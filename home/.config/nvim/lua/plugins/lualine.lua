local Util = require("lazyvim.util")

-- todo submit PR to lualine to add this feature
local function shortenPath(path)
  local PATH_TRUNCATION_LENGTH_START = 3
  local PATH_TRUNCATION_LENGTH_END = 3
  local len = #path
  if len <= (PATH_TRUNCATION_LENGTH_START + PATH_TRUNCATION_LENGTH_END) then
    return path
  else
    local combined = {}

    for i = 1, PATH_TRUNCATION_LENGTH_START do
      table.insert(combined, path[i])
    end

    table.insert(combined, "…")

    for i = len - PATH_TRUNCATION_LENGTH_END + 1, len do
      table.insert(combined, path[i])
    end


    return combined
  end
end

-- Modified version fo lualine.pretty_path(), to show longer paths
local function my_pretty_path()
  local path = vim.fn.expand("%:p")

  if path == "" then
    return ""
  end
  local cwd = Util.root.cwd()

  path = path:sub(#cwd + 2)

  local sep = "/"
  local parts = vim.split(path, "[\\/]")
  parts = shortenPath(parts)
  local s = table.concat(parts, sep)
  return s;
end

return { {
  "nvim-lualine/lualine.nvim",
  event = "VeryLazy",
  init = function()
    vim.g.lualine_laststatus = vim.o.laststatus
    if vim.fn.argc(-1) > 0 then
      -- set an empty statusline till lualine loads
      vim.o.statusline = " "
    else
      -- hide the statusline on the starter page
      vim.o.laststatus = 0
    end
  end,
  opts = function()
    -- PERF: we don't need this lualine require madness 🤷
    local lualine_require = require("lualine_require")
    lualine_require.require = require

    local icons = require("lazyvim.config").icons

    vim.o.laststatus = vim.g.lualine_laststatus

    return {
      options = {
        theme = "auto",
        globalstatus = true,
        disabled_filetypes = { statusline = { "dashboard", "alpha", "starter" } },
      },
      sections = {
        lualine_a = { "mode" },
        lualine_b = { "branch" },

        lualine_c = {
          {
            require("grapple").statusline
          },
          Util.lualine.root_dir(),
          { "filetype", icon_only = true, separator = "", padding = { left = 1, right = 0 } },
          my_pretty_path
        },
        lualine_x = {
          {
            "diagnostics",
            symbols = {
              error = icons.diagnostics.Error,
              warn = icons.diagnostics.Warn,
              info = icons.diagnostics.Info,
              hint = icons.diagnostics.Hint,
            },
          },

          -- stylua: ignore
          {
            function() return require("noice").api.status.command.get() end,
            cond = function() return package.loaded["noice"] and require("noice").api.status.command.has() end,
            color = Util.ui.fg("Statement"),
          },
          -- stylua: ignore
          {
            function() return require("noice").api.status.mode.get() end,
            cond = function() return package.loaded["noice"] and require("noice").api.status.mode.has() end,
            color = Util.ui.fg("Constant"),
          },
          -- stylua: ignore
          {
            function() return "  " .. require("dap").status() end,
            cond = function() return package.loaded["dap"] and require("dap").status() ~= "" end,
            color = Util.ui.fg("Debug"),
          },
          {
            require("lazy.status").updates,
            cond = require("lazy.status").has_updates,
            color = Util.ui.fg("Special"),
          },
          {
            "diff",
            symbols = {
              added = icons.git.added,
              modified = icons.git.modified,
              removed = icons.git.removed,
            },
            source = function()
              local gitsigns = vim.b.gitsigns_status_dict
              if gitsigns then
                return {
                  added = gitsigns.added,
                  modified = gitsigns.changed,
                  removed = gitsigns.removed,
                }
              end
            end,
          },
        },
        lualine_y = {
          { "progress", separator = " ",                  padding = { left = 1, right = 0 } },
          { "location", padding = { left = 0, right = 1 } },
        },
        lualine_z = {
          function()
            return " " .. os.date("%R")
          end,
        },
      },
      extensions = { "neo-tree", "lazy" },
    }
  end,
} }
