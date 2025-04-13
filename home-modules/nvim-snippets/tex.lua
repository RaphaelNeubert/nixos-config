local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local d = ls.dynamic_node
local f = ls.function_node

local function space_if_needed()
  local row, col = unpack(vim.api.nvim_win_get_cursor(0))
  local line = vim.api.nvim_get_current_line()

  local next_char = line:sub(col + 1, col + 1)
  if next_char == "" or not next_char:match("[%.,;:%!?)]") then
    return ls.text_node(" ")
  else
    return ls.text_node("")
  end
end

return {
	s({ trig = "mk", wordTrig = true, snippetType = "autosnippet" }, {
		t("$"),
		i(1),
		t("$"),
		-- d(2, space_if_needed, {}),
	}),
	s({ trig = "sr", wordTrig = false, snippetType = "autosnippet" }, {
		t("^2"),
		i(0),
	}),
}

