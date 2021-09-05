

local actions = require'omnimenu.actions'


local config = {}

config.config = {
}

config.setup = function(opts)

-- make sure tbl is empty first 
if not vim.tbl_isempty(config.config) then
table.remove(config.config, 1)
for i, item in ipairs(config.config) do
table.remove(config.config, 1)
end
end

for i, item in ipairs(opts) do
table.insert(config.config, item)
end
-- then iterate config, target all mappings and execute to add them
for i, item in ipairs(config.config) do
if item.keymap then
  for _, keymap in ipairs(item.keymap) do
            local action_str = [[<cmd>lua require'omnimenu'.config[]] .. i .. '].action()<cr>'
          vim.api.nvim_set_keymap(keymap[1], keymap[2], action_str, keymap[3])
      end
end

end


end

return config
