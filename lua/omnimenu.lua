-- IF uploading, will need to import put convert visual selection vim function into project
-- also need to get omnimenu config path dynamically
--
--

-- some more shiz
local omnimenu = {}

local actions = require("telescope.actions")
local action_state = require("telescope.actions.state")
local actions_set = require'telescope.actions.set'
local finders = require("telescope.finders")
local pickers = require("telescope.pickers")
local previewers = require("telescope.previewers")
local putils = require("telescope.previewers.utils")
local entry_display = require("telescope.pickers.entry_display")
local conf = require("telescope.config").values

local setup = require 'omnimenu/config'.setup
local config = require'omnimenu/config'.config
-- disable mappings for now
-- local keymaps = require'omnimenu/keymaps'.get_keymaps()
--  for k, v in pairs(keymaps) do table.insert(objs, v) end



omnimenu.show_telescope = function()
    local objs = {}

    for k, v in pairs(config) do table.insert(objs, v) end
     
    -- pr(objs)

    -- log1.info(config_custom)
    local displayer = entry_display.create {separator = " ", items = {{width = 10}, {width = 10}, {width = 10}, {remaining = true}}}

    local make_display = function(entry) return displayer {entry.value.cat, entry.value.subcat, entry.value.desc, entry.value.name} end

  local entry_maker = function(entry) 
                    return { 
                      value = entry, 
                      display = make_display, 
                      ordinal = entry.name,
                        } 
                      end

    pickers.new(opts,{
                prompt_title = "Omnimenu", 
                finder = finders.new_table {
                  results = objs, 
                  entry_maker = entry_maker, },
 attach_mappings = function(prompt_bufnr)
      actions_set.select:replace(function()
        local entry = actions.get_selected_entry()
        actions.close(prompt_bufnr)
        entry.value.action()
      end)
      return true
    end,

--                   attach_mappings = function(prompt_bufnr)
-- actions.select_default:replace(default_enter)
--   return true
-- end,



  sorter = conf.generic_sorter(opts)
                  }):find()


end





return {
show_telescope = omnimenu.show_telescope,
setup = setup,
config = config
}


