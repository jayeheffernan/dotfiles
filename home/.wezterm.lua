local wezterm = require("wezterm")
local act = wezterm.action

local colors = wezterm.get_builtin_color_schemes()['Catppuccin Mocha'];

-- Customize the default background color
-- colors.background = "rgba(0, 0, 0, 0)";
colors.background = "rgba(0, 0, 0, 1)";

return {
  font = wezterm.font("Fira Code"),
  font_size = 18.0,
  harfbuzz_features = { "ss10" },

  -- color_scheme = "Catppuccin Mocha",
  colors = colors,

  enable_tab_bar = false,
  adjust_window_size_when_changing_font_size = false,

  window_close_confirmation = "NeverPrompt",

  keys = {
    -- shift enter to clear-screen (^L) then enter (^M)
    { key = "Enter", mods = "SHIFT", action = act.SendString("\x0c\x0d") },
  },
}
