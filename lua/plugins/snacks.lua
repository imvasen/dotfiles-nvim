-- https://www.asciiart.eu/text-to-ascii-art
local ansi_header = [[
██╗   ██╗ █████╗ ███████╗███████╗███╗   ██╗
██║   ██║██╔══██╗██╔════╝██╔════╝████╗  ██║
██║   ██║███████║███████╗█████╗  ██╔██╗ ██║
╚██╗ ██╔╝██╔══██║╚════██║██╔══╝  ██║╚██╗██║
 ╚████╔╝ ██║  ██║███████║███████╗██║ ╚████║
  ╚═══╝  ╚═╝  ╚═╝╚══════╝╚══════╝╚═╝  ╚═══╝
]]

local star_wars_header = [[
____    ____  ___           _______. _______ .__   __.
\   \  /   / /   \         /       ||   ____||  \ |  |
 \   \/   / /  ^  \       |   (----`|  |__   |   \|  |
  \      / /  /_\  \       \   \    |   __|  |  . `  |
   \    / /  _____  \  .----)   |   |  |____ |  |\   |
    \__/ /__/     \__\ |_______/    |_______||__| \__|
]]

return {
  "folke/snacks.nvim",
  opts = {
    dashboard = {
      enabled = true,
      preset = {
        -- VASEN header
        header = ansi_header,
      },
      sections = {
        { section = "header", pane = 2 },
        { section = "keys", gap = 1, padding = 1 },
        {
          pane = 2,
          icon = " ",
          desc = "Browse Repo",
          padding = 1,
          key = "b",
          action = function()
            Snacks.gitbrowse()
          end,
        },
        function()
          local in_git = Snacks.git.get_root() ~= nil
          local cmds = {
            {
              title = "Notifications",
              cmd = "gh notify -s -a -n5",
              action = function()
                vim.ui.open("https://github.com/notifications")
              end,
              key = "N",
              icon = " ",
              height = 5,
              enabled = true,
            },
            {
              icon = " ",
              title = "Open PRs",
              cmd = "gh pr list -L 3",
              key = "p",
              action = function()
                vim.fn.jobstart("gh pr list --web", { detach = true })
              end,
              height = 7,
            },
            {
              icon = " ",
              title = "Git Status",
              cmd = "git --no-pager diff --stat -B -M -C",
              height = 10,
            },
          }
          return vim.tbl_map(function(cmd)
            return vim.tbl_extend("force", {
              pane = 2,
              section = "terminal",
              enabled = in_git,
              padding = 1,
              ttl = 5 * 60,
              indent = 3,
            }, cmd)
          end, cmds)
        end,
        { section = "startup" },
        {
          section = "terminal",
          cmd = "echo '\n\n';pokemon-colorscripts -rn $FAV_POKEMONS --no-title",
          height = 30,
          padding = 4,
          indent = 10,
          random = 10,
        },
      },
    },
  },
}
