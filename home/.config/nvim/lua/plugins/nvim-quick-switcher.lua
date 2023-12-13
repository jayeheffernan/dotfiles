local keymap = vim.keymap.set

return {
  {
    "Everduin94/nvim-quick-switcher",
    init = function()
      -- "e" for "edit" or "equivalent"

      -- s for styles
      keymap("n", "<leader>es", function()
          local before = vim.fn.expand('%:p')
          local after = before

          local patterns = {
            { ".scss",        1, false },
            { ".tsx",         1, false },
            { ".ts",          1, false },
            { ".jsx",         1, false },
            { ".js",          1, false },

            { ".styles.scss", 1, false },
            { ".styles.tsx",  1, false },
            { ".styles.ts",   1, false },
            { ".styles.jsx",  1, false },
            { ".styles.js",   1, false },

            { "styles.scss",  1, true },
            { "styles.tsx",   1, true },
            { "styles.ts",    1, true },
            { "styles.jsx",   1, true },
            { "styles.js",    1, true },

            { "styles.scss",  2, true },
            { "styles.tsx",   2, true },
            { "styles.ts",    2, true },
            { "styles.jsx",   2, true },
            { "styles.js",    2, true },
          }

          for _i, pattern in pairs(patterns) do
            require('nvim-quick-switcher').find(pattern[1], { maxdepth = pattern[2], ignore_prefix = pattern[3] });
            after = vim.fn.expand('%:p')
            if before ~= after then
              break
            end
          end
        end,
        { desc = "Jump to styles file" })
    end
  },
}
