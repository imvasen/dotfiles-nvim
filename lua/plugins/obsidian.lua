local vault_path = "/Users/vasen/Library/Mobile Documents/iCloud~md~obsidian/Documents/Main Vault"

local function exists(name)
  local ok, _, code = os.rename(name, name)

  if not ok and code ~= 13 then
    return false
  end

  return true
end

return {
  "epwalsh/obsidian.nvim",
  version = "*",
  lazy = false,
  enabled = exists(vault_path),
  ft = "markdown",
  dependencies = {
    "nvim-lua/plenary.nvim",
  },
  opts = {
    ui = { enable = true },
    workspaces = {
      {
        name = "Main",
        path = vault_path,
      },
    },
    templates = {
      folder = "templates",
      date_format = "%Y-%m-%d",
      time_format = "%H:%M",
    },
  },
}
