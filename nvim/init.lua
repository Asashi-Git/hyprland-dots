-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")

-- MATUGEN
local function source_matugen()
  local matugen_path = os.getenv("HOME") .. "/.config/nvim/generated.lua"

  local file, err = io.open(matugen_path, "r")
  if err ~= nil then
    vim.cmd("colorscheme base16-catppuccin-mocha")
    vim.print(
      "A matugen style file was not found, but that's okay! The colorscheme will dynamically change if matugen runs!"
    )
  else
    dofile(matugen_path)
    io.close(file)
  end
end

local function auxiliary_function()
  source_matugen()
  dofile(os.getenv("HOME") .. "/.config/nvim/config/plugins/lualine-nvim.lua")
  vim.api.nvim_set_hl(0, "Comment", { italic = true })
end

-- Load on startup
source_matugen()

-- Hot-reload on SIGUSR1
vim.api.nvim_create_autocmd("Signal", {
  pattern = "SIGUSR1",
  callback = auxiliary_function,
})
