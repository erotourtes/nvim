G = {}

G.plugin_hl = {}
G.const = {
  default_winblend = 15,
}

G.log = function(msg) print(vim.inspect(msg)) end

local utils = {}
G.utils = utils

utils.set = function(mode, keymap, action, desc)
  vim.keymap.set(mode, keymap, action, { desc = desc })
end

utils.tbl_name = function(tbl)
  local res = {}
  for _, v in ipairs(tbl) do
    table.insert(res, v)
  end
  return res
end

utils.tbl_each = function(tbl, fn)
  for k, v in pairs(tbl) do
    if type(v) == "string" then
      fn(v, {})
    elseif type(v) == "table" then
      fn(k, v)
    else
      assert(false, "Invalid type")
    end
  end
end
