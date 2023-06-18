return {
  {
    "ggandor/leap.nvim",
    opts = {
      safe_labels = {},
      labels = {
        "n",
        "t",
        "e",
        "s",
        "i",
        "r",
        "l",
        "p",
        "u",
        "f",
        "y",
        "w",
        "k",
        "v",
        "m",
        "c",
        ",",
        "x",
        "o",
        "a",
        ";",
        "q",
        "j",
        "g",
        ".",
        "/",

        "N",
        "T",
        "E",
        "S",
        "I",
        "R",
        "L",
        "P",
        "U",
        "F",
        "Y",
        "W",
        "K",
        "V",
        "M",
        "C",
        "X",
        "O",
        "A",
        "Q",
        "J",
        "G",
      },
    },
    config = function(_, opts)
      local leap = require("leap")
      for k, v in pairs(opts) do
        leap.opts[k] = v
      end
      leap.add_default_mappings(true)
      vim.keymap.del({ "x", "o" }, "x")
      vim.keymap.del({ "x", "o" }, "X")

      -- Restore "surround" mappings (surround will load first, leap is lazy-loaded)
      vim.keymap.set("n", "ds", "<Plug>Dsurround")
      vim.keymap.set("n", "cs", "<Plug>Csurround")
      vim.keymap.set("n", "cS", "<Plug>CSurround")
      vim.keymap.set("n", "ys", "<Plug>Ysurround")
      vim.keymap.set("n", "yS", "<Plug>YSurround")
      vim.keymap.set("n", "yss", "<Plug>Yssurround")
      vim.keymap.set("n", "ySs", "<Plug>YSsurround")
      vim.keymap.set("n", "ySS", "<Plug>YSsurround")

      -- Visual-mode mappings can prefer leap, but expose surround mappings under "g"
      vim.keymap.set("x", "gs", "<Plug>VSurround")
      vim.keymap.set("x", "gS", "<Plug>VgSurround")
    end,
  },
}
