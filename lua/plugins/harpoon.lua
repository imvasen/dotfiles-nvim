-- Snacks picker configuration for Harpoon
local function toggle_snacks_picker(harpoon_files)
  local function build_items()
    local items = {}
    for i, item in ipairs(harpoon_files.items) do
      local filename = vim.fn.fnamemodify(item.value, ":t")
      local display = string.format("[%d] %s", i, filename)
      table.insert(items, {
        text = display,
        value = item.value,
        file = item.value,
        path = item.value,
        idx = i,
      })
    end
    return items
  end

  local items = build_items()

  Snacks.picker({
    title = "Harpoon",
    items = items,
    on_select = function(item)
      if item then
        vim.cmd("edit " .. vim.fn.fnameescape(item.value))
      end
    end,
    actions = {
      harpoon_delete = function(picker, item)
        local to_remove = item or picker:selected()
        if to_remove then
          -- Remove from harpoon list using the index
          table.remove(harpoon_files.items, to_remove.idx)
          -- Close current picker and reopen with updated list
          vim.cmd("close")
          -- Use a timer to ensure the picker is fully closed before reopening
          vim.defer_fn(function()
            toggle_snacks_picker(harpoon_files)
          end, 1)
        end
      end,
    },
    win = {
      input = {
        keys = {
          ["<C-x>"] = { "harpoon_delete", mode = { "n", "i" } },
        },
      },
      list = {
        keys = {
          ["<C-x>"] = { "harpoon_delete", mode = { "n", "i" } },
        },
      },
    },
  })
end

return {
  "ThePrimeagen/harpoon",
  branch = "harpoon2",
  dependencies = {
    "nvim-lua/plenary.nvim",
  },
  keys = function()
    local keys = {
      {
        "<leader>eh",
        function()
          toggle_snacks_picker(require("harpoon"):list())
        end,
      },
      {
        "<leader>ea",
        function()
          require("harpoon"):list():add()
        end,
      },
    }

    for i = 1, 9 do
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
