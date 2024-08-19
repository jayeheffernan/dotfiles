return {
  {
    "nvimdev/dashboard-nvim",
    enabled = false,
  },
  {
    "goolord/alpha-nvim",
    opts = function()
      local dashboard = require("alpha.themes.dashboard")
      local logo = [[
      ---
      ]]

      dashboard.section.header.val = vim.split(logo, "\n")
      dashboard.section.buttons.val = {
        dashboard.button("f", " " .. " Find file", ":Files <CR>"),
        dashboard.button("r", " " .. " Recent files", ":History <CR>"),
        -- Kind of works, but requires "s" twice :/ will leave off for now
        -- dashboard.button("s", " " .. " Search", ":Rg "),
        dashboard.button("c", " " .. " Config", ":e ~/.config/nvim/lua/config/keymaps.lua <CR>"),
        dashboard.button("<CR>", " " .. " Restore Session", [[:lua require("persistence").load() <cr>]]),
        dashboard.button("l", "󰒲 " .. " Lazy", ":Lazy<CR>"),
        dashboard.button("q", " " .. " Quit", ":q<CR>"),
      }
      for _, button in ipairs(dashboard.section.buttons.val) do
        button.opts.hl = "AlphaButtons"
        button.opts.hl_shortcut = "AlphaShortcut"
      end
      dashboard.section.header.opts.hl = "AlphaHeader"
      dashboard.section.buttons.opts.hl = "AlphaButtons"
      dashboard.section.footer.opts.hl = "AlphaFooter"
      dashboard.opts.layout[1].val = 8
      return dashboard
    end,
  },
}
