return {
  {
    "ggandor/leap.nvim",
    keys = {
      { "x", mode = { "x", "o" }, desc = "Leap forward to" },
      { "X", mode = { "x", "o" }, desc = "Leap backward to" },
    },
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

      leap.add_default_mappings(false) -- false = no-force

      -- Visual-mode mappings for s/S can prefer surround, but expose leap mappings under x/X
      vim.keymap.set("x", "s", "<Plug>VSurround")
      vim.keymap.set("x", "S", "<Plug>VgSurround")
      vim.keymap.set({ "x", "o" }, "x", "<Plug>(leap-forward-to)")
      vim.keymap.set({ "x", "o" }, "X", "<Plug>(leap-backward-to)")
    end,
  },
}
