local Packer = {}

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
