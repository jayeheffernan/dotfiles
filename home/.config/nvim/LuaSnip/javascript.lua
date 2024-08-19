-- Abbreviations used in this article and the LuaSnip docs
local ls = require("luasnip")
local s = ls.snippet
local sn = ls.snippet_node
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local d = ls.dynamic_node
local fmt = require("luasnip.extras.fmt").fmt
local fmta = require("luasnip.extras.fmt").fmta
local rep = require("luasnip.extras").rep

math.randomseed(tonumber(tostring(os.time()):reverse():sub(1, 6)))

local charset = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890"
local function shortId(length)
  if length <= 1 then
    local i = math.random(1, #charset)
    return charset:sub(i, i);
  end
  return shortId(length - 1) .. shortId(1);
end

return {
  -- A snippet that expands the trigger "hi" into the string "Hello, world!".
  s(
    { trig = "hi" },
    { t("Hello, world!") }
  ),

  -- To return multiple snippets, use one `return` statement per snippet file
  -- and return a table of Lua snippets.
  s(
    { trig = "foo" },
    { t("Another snippet.") }
  ),

  s(
    { trig = "ld", dscr = "log debug" },
    { t("console.log(\"jaye "), i(2), f(function() return shortId(4) end, {}, {}),
      t("\", { "), i(1, "foo"), t(" });") }
  ),

  s( -- Insert over-line command
    { trig = "tc", dscr = "autosnippet" },
    fmt(
      [[
        try {
          <>
        } catch (err) {
          <>
        }
      ]],
      { i(0), i(1, "throw err;") },
      { delimiters = "<>" }
    )
  ),

}
