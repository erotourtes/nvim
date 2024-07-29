local loaded, harpoon = pcall(require, "harpoon")
if not loaded then return end

harpoon:setup({
  settings = {
    save_on_toggle = true,
  }
})

local set = G.utils.set

set("n", "<leader>ha", function() harpoon:list():add() end, "Add current file to Harpoon")
set(
  "n",
  "<leader>hm",
  function() harpoon.ui:toggle_quick_menu(harpoon:list()) end,
  "Open Harpoon menu"
)
set("n", "<M-j>", function() harpoon:list():select(1) end, "Select Harpoon list 1")
set("n", "<M-k>", function() harpoon:list():select(2) end, "Select Harpoon list 2")
set("n", "<M-l>", function() harpoon:list():select(3) end, "Select Harpoon list 3")
set("n", "<M-;>", function() harpoon:list():select(4) end, "Select Harpoon list 4")

table.insert(G.plugin_hl, function(color)
  -- Make Harpoon transparent
  vim.api.nvim_set_hl(0, "HarpoonBorder", { bg = nil, fg = color.fg })
  vim.api.nvim_set_hl(0, "HarpoonWindow", { bg = nil, fg = color.fg })
end)
