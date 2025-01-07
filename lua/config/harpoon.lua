local harpoon = require("harpoon")
harpoon:setup({})

-- basic telescope configuration
local conf = require("telescope.config").values
local function toggle_telescope(harpoon_files)
  local file_paths = {}
  for _, item in ipairs(harpoon_files.items) do
    table.insert(file_paths, item.value)
  end

  local finder = function()
    local paths = {}
    for _, item in ipairs(harpoon_files.items) do
      table.insert(paths, item.value)
    end

    return require("telescope.finders").new_table({
      results = paths,
    })
  end

  require("telescope.pickers")
    .new({}, {
      prompt_title = "Harpoon",
      finder = finder(),
      previewer = conf.file_previewer({}),
      sorter = conf.generic_sorter({}),
      attach_mappings = function(prompt_bufnr, map)
        map({ "n", "i" }, "<C-d>", function()
          local state = require("telescope.actions.state")
          local selected_entry = state.get_selected_entry()
          local current_picker = state.get_current_picker(prompt_bufnr)

          table.remove(harpoon_files.items, selected_entry.index)
          current_picker:refresh(finder())
        end)
        return true
      end,
    })
    :find()
end

vim.keymap.set("n", "<leader>ee", function()
  toggle_telescope(harpoon:list())
end)
vim.keymap.set("n", "<leader>ea", function()
  harpoon:list():add()
end)

-- Toggle previous & next buffers stored within Harpoon list
vim.keymap.set("n", "<C-M-P>", function()
  harpoon:list():prev()
end)
vim.keymap.set("n", "<C-M-N>", function()
  harpoon:list():next()
end)
