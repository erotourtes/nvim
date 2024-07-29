local function visual_cursors_with_delay()
  -- Execute the vm-visual-cursors command.
  vim.cmd('silent! execute "normal! \\<Plug>(VM-Visual-Cursors)"')
  -- Introduce delay via VimScript's 'sleep' (set to 500 milliseconds here).
  vim.cmd("sleep 200m")
  -- Press 'A' in normal mode after the delay.
  vim.cmd('silent! execute "normal! A"')
end

vim.keymap.set("n", "<leader>ma", "<Plug>(VM-Select-All)<Tab>", { desc = "Select All" })
vim.keymap.set(
  "n",
  "<leader>mr",
  "<Plug>(VM-Start-Regex-Search)",
  { desc = "Start Regex Search" }
)
vim.keymap.set(
  "n",
  "<leader>mp",
  "<Plug>(VM-Add-Cursor-At-Pos)",
  { desc = "Add Cursor At Pos" }
)
vim.keymap.set("n", "<leader>mv", visual_cursors_with_delay, { desc = "Visual Cursors" })
vim.keymap.set(
  "n",
  "<leader>mo",
  "<Plug>(VM-Toggle-Mappings)",
  { desc = "Toggle Mapping" }
)
