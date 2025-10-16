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

-- Helper function to detect repository type
local function get_repo_type()
  local git_root = Snacks.git.get_root()
  if not git_root then
    return nil
  end

  -- Check remote origin URL
  local handle = io.popen("cd " .. vim.fn.shellescape(git_root) .. " && git remote get-url origin 2>/dev/null")
  if not handle then
    return nil
  end

  local remote_url = handle:read("*a")
  handle:close()

  if not remote_url or remote_url == "" then
    return nil
  end

  -- Detect different Git hosting platforms
  if remote_url:match("github%.com") then
    return "github"
  elseif remote_url:match("gitlab%.com") or remote_url:match("gitlab%.") then
    return "gitlab"
  elseif remote_url:match("bitbucket%.org") or remote_url:match("bitbucket%.") then
    return "bitbucket"
  elseif remote_url:match("dev%.azure%.com") or remote_url:match("visualstudio%.com") then
    return "azure"
  elseif remote_url:match("sourceforge%.net") then
    return "sourceforge"
  else
    return "other"
  end
end

-- Helper function to detect if current repository is hosted on GitHub
local function is_github_repo()
  return get_repo_type() == "github"
end

-- Helper function to get repository browse URL
local function get_repo_browse_url()
  local repo_type = get_repo_type()
  if not repo_type then
    return nil
  end

  local git_root = Snacks.git.get_root() or ""
  local handle = io.popen("cd " .. vim.fn.shellescape(git_root) .. " && git remote get-url origin 2>/dev/null")
  if not handle then
    return nil
  end

  local remote_url = handle:read("*a")
  handle:close()

  if not remote_url or remote_url == "" then
    return nil
  end

  -- Convert SSH URLs to HTTPS for browsing
  local browse_url = remote_url
    :gsub("git@github%.com:", "https://github.com/")
    :gsub("git@gitlab%.com:", "https://gitlab.com/")
    :gsub("git@gitlab%.", "https://gitlab.")
    :gsub("git@bitbucket%.org:", "https://bitbucket.org/")
    :gsub("git@dev%.azure%.com:", "https://dev.azure.com/")
    :gsub("%.git\n$", "")

  return browse_url
end

-- Helper function to get repository owner and name
local function get_repo_name()
  local repo_type = get_repo_type()
  if not repo_type then
    return nil
  end

  local git_root = Snacks.git.get_root() or ""
  local handle = io.popen("cd " .. vim.fn.shellescape(git_root) .. " && git remote get-url origin 2>/dev/null")
  if not handle then
    return nil
  end

  local remote_url = handle:read("*a")
  handle:close()

  if not remote_url or remote_url == "" then
    return nil
  end

  -- Convert SSH URLs to HTTPS for browsing
  local browse_url = remote_url
    :gsub("git@github%.com:", "")
    :gsub("git@gitlab%.com:", "")
    :gsub("git@gitlab%.", "")
    :gsub("git@bitbucket%.org:", "")
    :gsub("git@dev%.azure%.com:", "")
    :gsub("%.git\n$", "")

  return browse_url
end

-- Helper function to safely run GitHub CLI commands
local function safe_gh_command(cmd, fallback_msg)
  return function()
    if not is_github_repo() then
      vim.notify(fallback_msg or "This repository is not hosted on GitHub", vim.log.levels.WARN)
      return
    end

    -- Check if gh CLI is available
    local gh_check = vim.fn.system("which gh")
    if vim.v.shell_error ~= 0 then
      vim.notify("GitHub CLI (gh) is not installed", vim.log.levels.ERROR)
      return
    end

    vim.fn.jobstart(cmd, { detach = true })
  end
end

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
          icon = "󰖟 ",
          desc = "Browse Repo",
          padding = 1,
          key = "b",
          action = function()
            local browse_url = get_repo_browse_url()
            if browse_url then
              vim.ui.open(browse_url)
            else
              -- Fallback to Snacks.gitbrowse() if we can't determine the URL
              Snacks.gitbrowse()
            end
          end,
        },
        function()
          local in_git = Snacks.git.get_root() ~= nil
          local is_github = is_github_repo()
          local cmds = {
            {
              title = "Notifications",
              cmd = "gh notify -s -a -f " .. get_repo_name(),
              action = function()
                if not is_github then
                  vim.notify("This repository is not hosted on GitHub", vim.log.levels.WARN)
                  return
                end
                vim.ui.open("https://github.com/notifications")
              end,
              key = "N",
              icon = " ",
              height = 5,
              enabled = is_github,
            },
            {
              icon = " ",
              title = "Open PRs",
              cmd = "gh pr list -L 5",
              key = "p",
              action = safe_gh_command("gh pr list --web", "This repository is not hosted on GitHub"),
              height = 7,
              enabled = is_github,
            },
            {
              icon = " ",
              title = "Git Status",
              cmd = "git --no-pager diff --stat -B -M -C",
              height = 5,
            },
            -- GitLab specific section
            {
              icon = " ",
              title = "Merge Requests",
              cmd = 'glab mr list --per-page 5 --search "SCLP-"',
              key = "m",
              action = function()
                local repo_type = get_repo_type()
                if repo_type == "gitlab" then
                  local browse_url = get_repo_browse_url()
                  if browse_url then
                    vim.ui.open(browse_url .. "/-/merge_requests")
                  end
                else
                  vim.notify("This repository is not hosted on GitLab", vim.log.levels.WARN)
                end
              end,
              height = 7,
              enabled = get_repo_type() == "gitlab",
            },
            -- Alternative sections for non-GitHub/GitLab repositories
            {
              icon = " ",
              title = "Recent Commits",
              cmd = "git log --oneline -10 --graph --decorate",
              -- key = "c",
              height = 8,
              enabled = in_git and not is_github,
            },
            {
              icon = " ",
              title = "Branch Info",
              cmd = "git branch -vv && echo '' && git status --porcelain",
              -- key = "i",
              height = 6,
              enabled = in_git and not is_github,
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
