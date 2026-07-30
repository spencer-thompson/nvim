# Neovim Config

Personal Neovim configuration targeting Neovim 0.12.

## Structure

- `lua/sthompson/`: core options, keymaps, autocmds, and built-in cleanup.
- `lua/pack/`: plugin installation and configuration through `vim.pack`.
- `after/lsp/`: per-server LSP settings.
- `after/ftplugin/`: filetype-specific settings.

## Plugins

[`lua/pack/init.lua`](./lua/pack/init.lua) loads the plugin modules. Run `<leader>up` inside Neovim to call
`vim.pack.update()`. Resolved plugin versions live in `nvim-pack-lock.json`.

For a smaller troubleshooting configuration, start Neovim with:

```sh
nvim -u ~/.config/nvim/minimal.lua
```
