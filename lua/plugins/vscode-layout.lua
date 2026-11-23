-- VSCode-like startup: `nvim <dir>` opens the dir as the project with
-- neo-tree docked on the left and the dashboard in the editor area.

---@type LazySpec
return {
  -- stop neo-tree from taking over the directory buffer full-screen
  {
    "nvim-neo-tree/neo-tree.nvim",
    opts = { filesystem = { hijack_netrw_behavior = "disabled" } },
  },
  -- on `nvim <dir>`: cd into it, show dashboard, dock neo-tree on the left
  {
    "AstroNvim/astrocore",
    opts = {
      autocmds = {
        vscode_layout = {
          {
            event = "VimEnter",
            nested = true,
            desc = "VSCode-like layout when opening a directory",
            callback = function()
              if vim.fn.argc() ~= 1 then return end
              local dir = vim.fn.fnamemodify(vim.fn.argv(0), ":p")
              if vim.fn.isdirectory(dir) == 0 then return end
              local dirbuf = vim.api.nvim_get_current_buf()
              vim.cmd.cd(dir)
              vim.cmd.enew()
              pcall(vim.api.nvim_buf_delete, dirbuf, { force = true })
              pcall(function() require("snacks").dashboard() end) -- dashboard in the editor area
              vim.cmd "Neotree show left" -- `show` keeps focus in the editor
            end,
          },
        },
      },
    },
  },
}
