require("core.defaults")
require("core.keymaps")

if not pcall(require, "packer") then
  require("plugins.packer").bootstrap()
else
  require("plugins.packer").startup(require("plugins"))
end
