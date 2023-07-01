-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

function OpenInVsCode()
  local git_root = vim.fn.fnameescape(vim.fn.trim(vim.fn.system("git rev-parse --show-toplevel")))
  local loc = vim.fn.join({ vim.fn.fnameescape(vim.fn.getreg("%")), ":", vim.fn.line("."), ":", vim.fn.col(".") }, "")
  local command = "code '" .. git_root .. "' --goto '" .. loc .. "'"
  vim.fn.system(command)
end

local function get_buffer_dir()
  ---@type string?
  local path = vim.api.nvim_buf_get_name(0)
  path = path ~= "" and vim.loop.fs_realpath(path) or nil
  path = path and vim.fs.dirname(path) or vim.loop.cwd()
  return path
end

-- Start LazyVim defaults, copied from GitHub
local Util = require("lazyvim.util")

local function map(mode, lhs, rhs, opts)
  local keys = require("lazy.core.handler").handlers.keys
  ---@cast keys LazyKeysHandler
  -- do not create the keymap if a lazy keys handler exists
  if not keys.active[keys.parse({ lhs, mode = mode }).id] then
    opts = opts or {}
    opts.silent = opts.silent ~= false
    if opts.remap and not vim.g.vscode then
      opts.remap = nil
    end
    vim.keymap.set(mode, lhs, rhs, opts)
  end
end

-- -- better up/down
-- map({ "n", "x" }, "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
-- map({ "n", "x" }, "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
--
-- Move to window using the <ctrl> hjkl keys
map("n", "<leader>wh", "<C-w>h", { desc = "Go to left window", remap = true })
map("n", "<leader>wj", "<C-w>j", { desc = "Go to lower window", remap = true })
map("n", "<leader>wk", "<C-w>k", { desc = "Go to upper window", remap = true })
map("n", "<leader>wl", "<C-w>l", { desc = "Go to right window", remap = true })
-- map("n", "<C-h>", "<C-w>h", { desc = "Go to left window", remap = true })
-- map("n", "<C-j>", "<C-w>j", { desc = "Go to lower window", remap = true })
-- map("n", "<C-k>", "<C-w>k", { desc = "Go to upper window", remap = true })
-- map("n", "<C-l>", "<C-w>l", { desc = "Go to right window", remap = true })

-- Resize window using <ctrl> arrow keys
map("n", "<leader>wH", "<cmd>resize +2<cr>", { desc = "Increase window height" })
map("n", "<leader>wJ", "<cmd>resize -2<cr>", { desc = "Decrease window height" })
map("n", "<leader>wK", "<cmd>vertical resize -2<cr>", { desc = "Decrease window width" })
map("n", "<leader>wL", "<cmd>vertical resize +2<cr>", { desc = "Increase window width" })

-- -- Move Lines
-- map("n", "<A-j>", "<cmd>m .+1<cr>==", { desc = "Move down" })
-- map("n", "<A-k>", "<cmd>m .-2<cr>==", { desc = "Move up" })
-- map("i", "<A-j>", "<esc><cmd>m .+1<cr>==gi", { desc = "Move down" })
-- map("i", "<A-k>", "<esc><cmd>m .-2<cr>==gi", { desc = "Move up" })
-- map("v", "<A-j>", ":m '>+1<cr>gv=gv", { desc = "Move down" })
-- map("v", "<A-k>", ":m '<-2<cr>gv=gv", { desc = "Move up" })
--
-- -- buffers
-- if Util.has("bufferline.nvim") then
--   map("n", "<S-h>", "<cmd>BufferLineCyclePrev<cr>", { desc = "Prev buffer" })
--   map("n", "<S-l>", "<cmd>BufferLineCycleNext<cr>", { desc = "Next buffer" })
--   map("n", "[b", "<cmd>BufferLineCyclePrev<cr>", { desc = "Prev buffer" })
--   map("n", "]b", "<cmd>BufferLineCycleNext<cr>", { desc = "Next buffer" })
-- else
--   map("n", "<S-h>", "<cmd>bprevious<cr>", { desc = "Prev buffer" })
--   map("n", "<S-l>", "<cmd>bnext<cr>", { desc = "Next buffer" })
--   map("n", "[b", "<cmd>bprevious<cr>", { desc = "Prev buffer" })
--   map("n", "]b", "<cmd>bnext<cr>", { desc = "Next buffer" })
-- end

map("n", "<leader>bb", "<cmd>e #<cr>", { desc = "Switch to Other Buffer" })
-- map("n", "<leader>`", "<cmd>e #<cr>", { desc = "Switch to Other Buffer" })

-- Clear search with <esc>
map({ "i", "n" }, "<esc>", "<cmd>noh<cr><esc>", { desc = "Escape and clear hlsearch" })

-- Clear search, diff update and redraw
-- taken from runtime/lua/_editor.lua
map(
  "n",
  "<leader>ur",
  "<Cmd>nohlsearch<Bar>diffupdate<Bar>normal! <C-L><CR>",
  { desc = "Redraw / clear hlsearch / diff update" }
)

-- -- map({ "n", "x" }, "gw", "*N", { desc = "Search word under cursor" })
-- --
-- -- -- https://github.com/mhinz/vim-galore#saner-behavior-of-n-and-n
-- -- map("n", "n", "'Nn'[v:searchforward]", { expr = true, desc = "Next search result" })
-- -- map("x", "n", "'Nn'[v:searchforward]", { expr = true, desc = "Next search result" })
-- -- map("o", "n", "'Nn'[v:searchforward]", { expr = true, desc = "Next search result" })
-- -- map("n", "N", "'nN'[v:searchforward]", { expr = true, desc = "Prev search result" })
-- -- map("x", "N", "'nN'[v:searchforward]", { expr = true, desc = "Prev search result" })
-- -- map("o", "N", "'nN'[v:searchforward]", { expr = true, desc = "Prev search result" })
-- --
-- -- Add undo break-points
-- map("i", ",", ",<c-g>u")
-- map("i", ".", ".<c-g>u")
-- map("i", ";", ";<c-g>u")
--
-- save file
map({ "i", "v", "n", "s" }, "<C-s>", "<cmd>w<cr><esc>", { desc = "Save file" })

-- better indenting
map("v", "<", "<gv")
map("v", ">", ">gv")

-- lazy
map("n", "<leader>l", "<cmd>:Lazy<cr>", { desc = "Lazy" })

-- new file
map("n", "<leader>fn", "<cmd>enew<cr>", { desc = "New File" })

map("n", "<leader>xl", "<cmd>lopen<cr>", { desc = "Location List" })
map("n", "<leader>xq", "<cmd>copen<cr>", { desc = "Quickfix List" })

if not Util.has("trouble.nvim") then
  map("n", "[q", vim.cmd.cprev, { desc = "Previous quickfix" })
  map("n", "]q", vim.cmd.cnext, { desc = "Next quickfix" })
end

-- toggle options
map("n", "<leader>uf", require("lazyvim.plugins.lsp.format").toggle, { desc = "Toggle format on Save" })
map("n", "<leader>us", function()
  Util.toggle("spell")
end, { desc = "Toggle Spelling" })
map("n", "<leader>uw", function()
  Util.toggle("wrap")
end, { desc = "Toggle Word Wrap" })
map("n", "<leader>ul", function()
  Util.toggle("relativenumber", true)
  Util.toggle("number")
end, { desc = "Toggle Line Numbers" })
map("n", "<leader>ud", Util.toggle_diagnostics, { desc = "Toggle Diagnostics" })
local conceallevel = vim.o.conceallevel > 0 and vim.o.conceallevel or 3
map("n", "<leader>uc", function()
  Util.toggle("conceallevel", false, { 0, conceallevel })
end, { desc = "Toggle Conceal" })

-- -- lazygit
-- map("n", "<leader>gg", function() Util.float_term({ "lazygit" }, { cwd = Util.get_root(), esc_esc = false, ctrl_hjkl = false }) end, { desc = "Lazygit (root dir)" })
-- map("n", "<leader>gG", function() Util.float_term({ "lazygit" }, {esc_esc = false, ctrl_hjkl = false}) end, { desc = "Lazygit (cwd)" })
--
-- quit
map("n", "<leader>qq", "<cmd>qa<cr>", { desc = "Quit all" })

-- highlights under cursor
if vim.fn.has("nvim-0.9.0") == 1 then
  map("n", "<leader>ui", vim.show_pos, { desc = "Inspect Pos" })
end

-- -- floating terminal
local lazyterm = function()
  Util.float_term(nil, { cwd = Util.get_root() })
end
map("n", "<leader>fT", lazyterm, { desc = "Terminal (root dir)" })
map("n", "<leader>ft", function()
  Util.float_term(nil, { cwd = get_buffer_dir() })
end, { desc = "Terminal (file dir)" })
-- map("n", "<c-/>", lazyterm, { desc = "Terminal (root dir)" })
-- map("n", "<c-_>", lazyterm, { desc = "which_key_ignore" })
--
-- -- Terminal Mappings
map("t", "<esc><esc>", "<c-\\><c-n>", { desc = "Enter Normal Mode" })
-- map("t", "<C-h>", "<cmd>wincmd h<cr>", { desc = "Go to left window" })
-- map("t", "<C-j>", "<cmd>wincmd j<cr>", { desc = "Go to lower window" })
-- map("t", "<C-k>", "<cmd>wincmd k<cr>", { desc = "Go to upper window" })
-- map("t", "<C-l>", "<cmd>wincmd l<cr>", { desc = "Go to right window" })
-- map("t", "<C-/>", "<cmd>close<cr>", { desc = "Hide Terminal" })
-- map("t", "<c-_>", "<cmd>close<cr>", { desc = "which_key_ignore" })
--
-- windows
map("n", "<leader>ww", "<C-W>p", { desc = "Other window", remap = true })
map("n", "<leader>wd", "<C-W>c", { desc = "Delete window", remap = true })
map("n", "<leader>w-", "<C-W>s", { desc = "Split window below", remap = true })
map("n", "<leader>w|", "<C-W>v", { desc = "Split window right", remap = true })
-- map("n", "<leader>-", "<C-W>s", { desc = "Split window below", remap = true })
-- map("n", "<leader>|", "<C-W>v", { desc = "Split window right", remap = true })

-- tabs
-- map("n", "<leader><tab>l", "<cmd>tablast<cr>", { desc = "Last Tab" })
-- map("n", "<leader><tab>f", "<cmd>tabfirst<cr>", { desc = "First Tab" })
-- map("n", "<leader><tab><tab>", "<cmd>tabnew<cr>", { desc = "New Tab" })
-- map("n", "<leader><tab>]", "<cmd>tabnext<cr>", { desc = "Next Tab" })
-- map("n", "<leader><tab>d", "<cmd>tabclose<cr>", { desc = "Close Tab" })
-- map("n", "<leader><tab>[", "<cmd>tabprevious<cr>", { desc = "Previous Tab" })
-- End LazyVim defaults, copied from GitHub

local keymap = vim.keymap.set

keymap({ "n", "x" }, "'", ":")
keymap("n", "<localleader>w", ":update<return>", { desc = "Save file" })

keymap("n", "<leader>v", "gd", { remap = true, desc = "Go to definition" })

-- Next/previous mapping prefixes, but easier to type
keymap("n", "<leader>N", "[", { remap = true })
keymap("n", "<leader>n", "]", { remap = true })

-- Copy/paste stuff
keymap({ "n", "x" }, "<leader>yy", '"+y', { desc = "Yank" })
keymap({ "n", "x" }, "<leader>yd", '"+d', { desc = "Delete" })
keymap({ "n", "x" }, "<leader>yp", '"+p', { desc = "Paste" })
keymap({ "n", "x" }, "<leader>yP", '"+P', { desc = "Paste behind" })
keymap("n", "<leader>yf", ':let @+=expand("%")<CR>', { desc = "Copy filename (relative)" })
keymap("n", "<leader>yF", ':let @+=expand("%:p")<CR>', { desc = "Copy filename (absolute)" })

keymap({ "n", "x" }, "p", "<Plug>(YankyPutAfter)")
keymap({ "n", "x" }, "P", "<Plug>(YankyPutBefore)")
keymap({ "n", "x" }, "gp", "<Plug>(YankyGPutAfter)")
keymap({ "n", "x" }, "gP", "<Plug>(YankyGPutBefore)")
keymap("n", "]p", "<Plug>(YankyCycleForward)", { desc = "Next paste option" })
keymap("n", "[p", "<Plug>(YankyCycleBackward)", { desc = "Previous paste option" })

local wk = require("which-key")
wk.register({
  ["<leader>n"] = { name = "+next" },
  ["<leader>N"] = { name = "+next" },
  ["<leader>dl"] = { name = "+list" },
  ["<leader>df"] = { name = "+focus" },
  ["<leader>dw"] = { name = "+widgets" },
})

-- Redo some telescope mapppings, e.g. <leader>fb to find buffers should also
-- be available as <leader>bf
keymap("n", "<leader>bf", "<cmd>Telescope buffers<cr>", { desc = "Find" })

keymap("n", "<leader>wo", "<C-W>o", { desc = "Only window (close others)" })

keymap({ "i", "s" }, "<C-Space>", function()
  require("luasnip").expand_or_jump(1)
end, { desc = "LuaSnip expand/forward jump" })
keymap({ "i", "s" }, "<C-h>", function()
  require("luasnip").jump(-1)
end, { desc = "LuaSnip backward jump" })

keymap("n", "<leader>ov", OpenInVsCode, { desc = "VS Code" })

keymap({ "n", "x" }, "<leader>fe", function()
  require("oil").toggle_float()
end, { desc = "Explore (file dir)" })
keymap({ "n", "x" }, "<leader>fE", function()
  require("oil").toggle_float(require("lazyvim.util").get_root())
end, { desc = "Explore (root dir)" })

keymap("n", "<leader>gb", ":Git blame<CR>", { desc = "Blame" })
keymap("n", "<leader>gg", ":Git ", { desc = "Git" })

-- NB: harpoon stuff here is probably junk. Not currently in-use. Just playing
-- around with some ideas.
keymap({ "n", "x" }, "<leader>hm", function()
  require("harpoon.mark").add_file()
end, { desc = "Harpoon mark" })

keymap({ "n", "x" }, "<leader>hh", function()
  require("harpoon.ui").toggle_quick_menu()
end, { desc = "Harpoon mark" })

local hutils = require("harpoon.utils")
function goToTmux(twindow, tpane)
  local _, ret, stderr = hutils.get_os_command_output({
    "tmux",
    "select-window",
    "-t",
    twindow,
  }, vim.loop.cwd())

  if ret ~= 0 then
    error("Failed to go to window." .. stderr[1])
  end
  local _, ret, stderr = hutils.get_os_command_output({
    "tmux",
    "select-pane",
    "-t",
    twindow .. "." .. tpane,
  }, vim.loop.cwd())

  if ret ~= 0 then
    error("Failed to go to window." .. stderr[1])
  end
end

keymap({ "n", "x" }, "<leader>ht", function()
  goToTmux("logs:ludwig", "{bottom}")
end, { desc = "Harpoon mark" })
