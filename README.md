# Neovim Config

This is where the magic happens 😎

## plugins

This is _certainly_ not all of the plugins included, but rather the plugins that provide the most value.

## installation

You _can_ clone the repo, but god only knows if it will work on your machine 😉

### settings

There are many many settings, mine are in [settings.lua](./lua/sthompson/settings.lua).
Additionally, I like to have my base settings and remaps separate from all my plugins.
In case I accidentally break the plugins, I still have those.

### lazy

This is what installs and manages all the plugins.

- [lazy.nvim](https://github.com/folke/lazy.nvim) see [init.lua](./lua/plugins/init.lua)

### mini

Mini is a set of plugins that provides a ton of easy to add and configure functionality.

- [mini.nvim](https://github.com/echasnovski/mini.nvim) see [mini.lua](./lua/plugins/mini.lua)

### snacks

This is the fancy dashboard, and other _icing_ on the cake per say.

- [snacks.nvim](https://github.com/folke/snacks.nvim) see [snacks.lua](./lua/plugins/snacks.lua)

### blink

This is the fancy super fast and easy to setup completion engine.

- [blink.cmp](https://github.com/Saghen/blink.cmp) see [code.lua](./lua/plugins/code.lua)

### lsp

LSP gives me information about my code, as well as extended capabilities.

- [nvim-lspconfig](https://github.com/neovim/nvim-lspconfig) see [lsp.lua](./lua/plugins/lsp.lua)

### autoformatting

Auto formatting is an absolute must have.

- [conform.nvim](https://github.com/stevearc/conform.nvim) see [format.lua](./lua/plugins/format.lua)
