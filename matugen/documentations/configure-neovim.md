# Matugen + Neovim - Step by Step

Let me follow the documentation **exactly**, no extras.

---

## Step 1: Install Plugins

```bash
nvim ~/.config/nvim/lua/plugins/base16.lua
```

```lua
return {
  "RRethy/base16-nvim",
  lazy = false,
  priority = 1000,
}
```

```bash
nvim ~/.config/nvim/lua/plugins/lualine.lua
```

```lua
return {
  "nvim-lualine/lualine.nvim",
  lazy = false,
}
```

Then sync:
```vim
:Lazy sync
```

---

## Step 2: Separate Lualine Config File

> The doc says to put lualine in its own file so matugen can `dofile()` it

```bash
mkdir -p ~/.config/nvim/config/plugins
nvim ~/.config/nvim/config/plugins/lualine-nvim.lua
```

```lua
require('lualine').setup({
  options = {
    theme = "base16",
  }
})
```

---

## Step 3: Matugen Template

```bash
mkdir -p ~/.config/matugen/templates
nvim ~/.config/matugen/templates/template.lua
```

```lua
require('base16-colorscheme').setup({
  base00 = "{{colors.background.default.hex}}",
  base01 = "{{colors.surface_container_lowest.default.hex}}",
  base02 = "{{colors.surface_container_low.default.hex}}",
  base03 = "{{colors.outline_variant.default.hex}}",
  base04 = "{{colors.on_surface_variant.default.hex}}",
  base05 = "{{colors.on_surface.default.hex}}",
  base06 = "{{colors.inverse_on_surface.default.hex}}",
  base07 = "{{colors.surface_bright.default.hex}}",
  base08 = "{{colors.tertiary.default.hex | lighten: -5}}",
  base09 = "{{colors.tertiary.default.hex}}",
  base0A = "{{colors.secondary.default.hex}}",
  base0B = "{{colors.primary.default.hex}}",
  base0C = "{{colors.tertiary_container.default.hex}}",
  base0D = "{{colors.primary_container.default.hex}}",
  base0E = "{{colors.secondary_container.default.hex}}",
  base0F = "{{colors.secondary.default.hex | lighten: -10}}",
})

vim.api.nvim_set_hl(0, 'Visual', {
  bg = '{{colors.primary_container.default.hex}}',
  fg = '{{colors.background.default.hex}}',
})

-- Re-source lualine so it picks up the new colors
dofile(os.getenv("HOME") .. '/.config/nvim/config/plugins/lualine-nvim.lua')
```

---

## Step 4: Matugen Config

```bash
nvim ~/.config/matugen/config.toml
```

```toml
[templates.neovim]
input_path = '~/.config/matugen/templates/template.lua'
output_path = '~/.config/nvim/generated.lua'
post_hook = 'pkill -SIGUSR1 nvim'
```

> ⚠️ The doc uses `'./template.lua'` as input_path but that is relative to where you run matugen. Using the **full path is safer**.

---

## Step 5: Edit init.lua

```bash
nvim ~/.config/nvim/init.lua
```

Add this at the top:

```lua
-- MATUGEN
local function source_matugen()
  local matugen_path = os.getenv("HOME") .. "/.config/nvim/generated.lua"

  local file, err = io.open(matugen_path, "r")
  if err ~= nil then
    vim.cmd('colorscheme base16-catppuccin-mocha')
    vim.print("A matugen style file was not found, but that's okay! The colorscheme will dynamically change if matugen runs!")
  else
    dofile(matugen_path)
    io.close(file)
  end
end

local function auxiliary_function()
  source_matugen()
  dofile(os.getenv("HOME") .. '/.config/nvim/config/plugins/lualine-nvim.lua')
  vim.api.nvim_set_hl(0, "Comment", { italic = true })
end

-- Load on startup
source_matugen()

-- Hot-reload on SIGUSR1
vim.api.nvim_create_autocmd("Signal", {
  pattern = "SIGUSR1",
  callback = auxiliary_function,
})
```

---

## Step 6: Test

```bash
# Run matugen on a wallpaper
matugen image ~/Pictures/wallpaper.jpg

# Check the generated file (should have real hex colors, no {{ }})
cat ~/.config/nvim/generated.lua

# Open neovim
nvim
```

---

## Full Flow Summary

```
matugen image wallpaper.jpg
        ↓
fills template.lua → writes generated.lua
        ↓
post_hook: pkill -SIGUSR1 nvim
        ↓
nvim receives signal → auxiliary_function()
        ↓
source_matugen() + lualine reload → colors update live ✓
```
