-- Terminals live in WezTerm panes, not inside Neovim.
-- When a WezTerm split shrinks this pane, long lines wrap; they unwrap when it grows back.

local WRAP_BELOW = 120 -- wrap when Neovim is narrower than this many columns

local function update_wrap()
  local narrow = vim.o.columns < WRAP_BELOW
  vim.o.wrap = narrow
  vim.o.linebreak = narrow
  for _, win in ipairs(vim.api.nvim_list_wins()) do
    local buf = vim.api.nvim_win_get_buf(win)
    local is_float = vim.api.nvim_win_get_config(win).relative ~= ""
    if not is_float and vim.bo[buf].buftype == "" then
      vim.wo[win].wrap = narrow
      vim.wo[win].linebreak = narrow
    end
  end
end

local function wezterm_split(dir)
  return function()
    if not vim.env.WEZTERM_PANE then
      vim.notify("Not running inside WezTerm", vim.log.levels.WARN)
      return
    end
    vim.fn.jobstart({ "wezterm", "cli", "split-pane", "--" .. dir, "--cwd", vim.fn.getcwd() }, { detach = true })
  end
end

---@type LazySpec
return {
  {
    "AstroNvim/astrocore",
    opts = {
      autocmds = {
        auto_wrap_narrow = {
          {
            event = { "VimEnter", "VimResized", "WinNew", "BufWinEnter" },
            desc = "Wrap lines when Neovim is narrow (e.g. beside a WezTerm split)",
            callback = update_wrap,
          },
        },
      },
      mappings = {
        n = {
          ["<Leader>tn"] = { wezterm_split "right", desc = "New WezTerm pane (right)" },
          ["<Leader>tN"] = { wezterm_split "bottom", desc = "New WezTerm pane (bottom)" },
        },
      },
    },
  },
}
