--[[ local actions = require("telescope.actions")
local action_state = require("telescope.actions.state")
local finders = require("telescope.finders")
local pickers = require("telescope.pickers")
local previewers = require("telescope.previewers")
local putils = require("telescope.previewers.utils")
local entry_display = require("telescope.pickers.entry_display")
local conf = require("telescope.config").values ]]

local M = {}
--local telekeymaps = function(opts)
 
function M.get_keymaps()
opts = opts or {}

  local objs = {}

  ------- mine below here
  local path = require("telescope/path")

  local rootdir = vim.fn.stdpath("config") .. "/lua" .. "/keymap"
  local file_list = io.popen("/bin/ls " .. rootdir)

  --local all_mappings = {}
  for filename in file_list:lines() do
    local filepath = rootdir .. "/" .. filename
   -- print(filepath)

    local data = path.read_file(filepath)
    
    local data = vim.split(data, "[\r]?\n")

    --objs = {a
    --po(data)
    for i, line in pairs(data) do
--po(line)

    --  -- take out everything that isnt api.nvim_set_keymap
      if line:find("^api.nvim_set_keymap") ~= nil then
  --po(line)
      
--po(line)
        local keymap, desc

        if line:match('%-%-') then 
        keymap = string.match(line, "(.*)%-%-.*$")
       keymap = keymap:gsub("%s+$", "")

print(line)
       
        desc = string.match(line, ".*%-%-(.*)$")
       desc = desc:gsub("^%s+", "")
       desc = "-- " .. desc
 if desc ~= nil then desc = '' end
        else
        keymap = line
        desc = ''
        end
       --print(desc)
       --print(keymap)
       table.insert(objs, {key = line, desc = desc, cat = 'keymap', subcat = filename})
     end
    end

 ---   table.insert(objs, data)

   -- print(name)
  end
return objs
end



return M
--[[ for k,v in pairs(objs) do
print(vim.v.desc)
    end ]]

  --[[ print(vim.inspect(objs))

  local displayer =
    entry_display.create {
    separator = " ",
    items = {
      {width = 200},
      {remaining = true}
    }
  }

  local make_display = function(entry)
    return displayer {
      entry.value.keymap,
      entry.value.desc
    }
  end

  pickers.new(
    opts,
    {
      prompt_title = "snippets",
      finder = finders.new_table {
        results = objs,
        entry_maker = function(entry)
          return {
            value = entry,
            display = make_display,
            ordinal = entry.keymap .. " " .. entry.desc
          }
        end
      },
      sorter = conf.generic_sorter(opts)
    }
  ):find() ]]



--telekeymaps()
