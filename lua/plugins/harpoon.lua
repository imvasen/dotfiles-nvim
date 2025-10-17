-- basic telescope configuration
local function toggle_telescope(harpoon_files)
  local conf = require("telescope.config").values
  local file_paths = {}
  for _, item in ipairs(harpoon_files.items) do
    table.insert(file_paths, item.value)
  end

  local finder = function()
    local results = {}
    for i, item in ipairs(harpoon_files.items) do
      local filename = vim.fn.fnamemodify(item.value, ":t")
      local display = string.format("[%d] %s", i, filename)
      table.insert(results, {
        value = item.value,
        display = display,
        ordinal = display,
        filename = filename,
        path = item.value,
      })
    end

    return require("telescope.finders").new_table({
      results = results,
      entry_maker = function(entry)
        return {
          value = entry.value,
          display = entry.display,
          ordinal = entry.ordinal,
          filename = entry.filename,
          path = entry.path,
        }
      end,
    })
  end

  require("telescope.pickers")
    .new({}, {
      prompt_title = "Harpoon",
      finder = finder(),
      previewer = conf.file_previewer({}),
      sorter = conf.generic_sorter({}),
      default_selection_index = 1,
      attach_mappings = function(prompt_bufnr, map)
        map({ "n", "i" }, "<C-x>", function()
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

return {
  "ThePrimeagen/harpoon",
  branch = "harpoon2",
  dependencies = {
    "nvim-lua/plenary.nvim",
    {
      "nvim-telescope/telescope.nvim",
      opts = {
        defaults = {
          layout_config = {
            preview_width = 0.6,
          },
        },
      },
    },
  },
  keys = function()
    local keys = {
      {
        "<leader>eh",
        function()
          toggle_telescope(require("harpoon"):list())
        end,
      },
      {
        "<leader>ea",
        function()
          require("harpoon"):list():add()
        end,
      },
    }

    for i = 1, 5 do
      table.insert(keys, {
        "<leader>" .. i,
        function()
          require("harpoon"):list():select(i)
        end,
        desc = "Harpoon #" .. i,
      })
    end

    return keys
  end,
}
