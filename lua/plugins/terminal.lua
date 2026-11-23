-- Always-new terminal splits (VSCode-style "new terminal").
-- Built-ins still work: <Leader>th / <Leader>tv / <Leader>tf, <F7> toggle.

local function new_term(direction)
  return function()
    local Terminal = require("toggleterm.terminal")
    local id = 1
    for _, t in ipairs(Terminal.get_all(true)) do
      id = math.max(id, t.id + 1)
    end
    Terminal.Terminal:new({ id = id, direction = direction }):toggle()
  end
end

---@type LazySpec
return {
  {
    "AstroNvim/astrocore",
    opts = {
      mappings = {
        n = {
          ["<Leader>tn"] = { new_term "horizontal", desc = "New horizontal terminal" },
          ["<Leader>tN"] = { new_term "vertical", desc = "New vertical terminal" },
        },
      },
    },
  },
}
