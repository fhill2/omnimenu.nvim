
local config_custom_path = '/home/f1/.config/nvim/plugins-me/omnimenu.nvim/lua/omnimenu/config_custom.lua' 
local reload = require'plenary/reload'.reload_module


function M.get_config_custom()

end


function M.save_to_config()

local config_custom = require'omnimenu/config_custom'.config_custom


-- f: clear cache and reload data from config_custom
reload('omnimenu/config_custom')
require('omnimenu/config_custom')

local key = vim.api.nvim_exec(
[[
let visual = GetVisualSelection()
echo visual
]], true)

local desc = vim.api.nvim_exec(
        [[
        let description = input('Description: ')
        echo description
        ]], true)

local cat = vim.api.nvim_exec(
        [[
        let category = input('Category: ')
        echo category
        ]], true)

local subcat = vim.api.nvim_exec(
    [[
    let subcategory = input('Subcategory: ')
    echo subcategory
    ]], true)

local new_entry = { key = key, desc = desc, cat = 'custom', subcat = subcat  }
--print(new_entry)
--print(config_custom)
local objs = {}
for k,v in pairs(config_custom) do
--print(v)
    table.insert(objs, v)
end

table.insert(objs, new_entry)
--log1.info(objs)
--local write = vim.inspect(config.custom)



local fp = io.open(config_custom_path, "w")
fp:write([[local M = {}]] .. '\n' .. [[M.config_custom = ]] .. vim.inspect(objs) .. '\nreturn M')
fp:close()


-- f: clear cache and reload data from config_custom
reload('omnimenu/config_custom')
require('omnimenu/config_custom')
reload('omnimenu')
require('omnimenu')
end

