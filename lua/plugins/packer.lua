local Packer = {}

function Packer.bootstrap()
  local fn = vim.fn
  local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"

  -- Remove awfull pink from the floating window
  vim.api.nvim_set_hl(0, "NormalFloat", { bg = "#1e222a" })

  if fn.empty(fn.glob(install_path)) > 0 then
    print("Cloning packer...")
    fn.system({ "git", "clone", "--depth", "1", "https://github.com/wbthomason/packer.nvim", install_path })

    -- Remove cloning message
    vim.cmd("redraw | echo")

    -- Install plugins and compile their configs
    vim.cmd("packadd packer.nvim")
    Packer.startup(require("plugins"))
    vim.fn.delete(require("packer").config.compile_path)
    vim.cmd("PackerSync")
  end
end

function Packer.startup(plugins)
    local loaded, packer = pcall(require, "packer")
    if not loaded then return end
    packer.startup(function(use)
        for plugin_name, config in pairs(plugins) do
            table.insert(config, plugin_name)
            use(config)
        end
    end)
end

return Packer
