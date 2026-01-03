# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Overview

This is a personal development configuration repository (`devcfg`) containing dotfiles and setup scripts for a development environment centered around Neovim, Zsh, Tmux, and GDB. The repository supports multiple operating systems (Ubuntu, Fedora, macOS) with platform-specific installation scripts.

## Repository Structure

```
.
├── .config/
│   ├── nvim/           # Neovim configuration (Lua-based, lazy.nvim plugin manager)
│   └── zsh/            # Zsh configuration with modular files
├── tmux/               # Tmux configuration
├── gdb/                # GDB configuration
├── bootstrap.sh        # Main entry point for system setup
└── *.sh                # Various installation and setup scripts
```

## Setup and Installation

### Initial Setup

Run the bootstrap script to set up the entire environment:
```bash
./bootstrap.sh
```

The bootstrap script detects the OS and runs the appropriate installation scripts:
- **Ubuntu**: `apt-install.sh` → `install_nerd_fonts.sh` → `setup-neovim.sh` → `setup-tmux.sh` → `setup-git.sh` → `setup-gdb.sh` → `install-zsh.sh`
- **Fedora**: `dnf-install.sh` → (same subsequent scripts)
- **macOS**: `homebrew-install.sh` → (same subsequent scripts)

### Platform-Specific Scripts

- **apt-install.sh**: Ubuntu package installation
- **dnf-install.sh**: Fedora package installation
- **homebrew-install.sh**: macOS Homebrew setup
- **setup-neovim.sh**: Neovim installation and configuration linking
- **setup-tmux.sh**: Tmux configuration linking
- **setup-git.sh**: Git configuration
- **setup-gdb.sh**: GDB configuration linking
- **install-zsh.sh**: Zsh installation and configuration

### Manual Installations

Optional tools with dedicated scripts:
```bash
./install-mold.sh           # Modern linker
./install-mongodb.sh        # MongoDB
./install-alacritty.sh      # Alacritty terminal
./install-bcc.sh            # BPF Compiler Collection
./install-bpfcc-tools.sh    # BPF tools
./install_nerd_fonts.sh     # Nerd Fonts for terminal icons
```

## Neovim Configuration

### Architecture

The Neovim configuration is located in `.config/nvim/` and uses:
- **Plugin Manager**: lazy.nvim (auto-bootstrapped)
- **Language**: Lua
- **Structure**: Modular plugin-based architecture

Entry point: `.config/nvim/init.lua` loads:
1. `kxhuan.core` - Core settings (options, keymaps, termdebug)
2. `kxhuan.lazy` - lazy.nvim bootstrap and plugin loading

### Plugin Organization

Plugins are organized in `.config/nvim/lua/kxhuan/plugins/`:
- `init.lua` - Essential plugins (plenary, vim-tmux-navigator)
- `lsp/mason.lua` - LSP server installer UI
- `lsp/mason-lspconfig.lua` - LSP server auto-installation
- `lsp/lspconfig.lua` - LSP server configuration (Neovim 0.11+ modern API)
- `telescope.lua` - Fuzzy finder
- `nvim-tree.lua` - File explorer
- `nvim-cmp.lua` - Completion engine
- `treesitter.lua` - Syntax highlighting and parsing
- `dap.lua` - Debug Adapter Protocol (GDB, Python debugpy)
- `conform.lua` - Code formatter
- `gitsigns.lua` - Git integration
- `colorscheme.lua` - Theme configuration
- Other UI/UX plugins

### LSP Servers

Uses Neovim 0.11+ modern API (`vim.lsp.config()` and `vim.lsp.enable()`).

**Architecture**:
- **Mason** (lsp/mason-lspconfig.lua) handles auto-installation
- **lspconfig** (lsp/lspconfig.lua) handles server configuration
- Clean separation of concerns: installation vs configuration

**Installed LSP servers** (auto-installed via Mason):
- **C/C++**: clangd
- **Python**: pyright
- **Lua**: lua_ls (for Neovim config)
- **Shell**: bashls
- **Build**: cmake
- **Data**: jsonls, yamlls
- **Rust**: rust_analyzer
- **JavaScript/TypeScript**: ts_ls
- **Nix**: nil_ls

**Adding new LSP servers**:
1. Add to `ensure_installed` list in `lsp/mason-lspconfig.lua`
2. Add `vim.lsp.config()` block in `lsp/lspconfig.lua`
3. Add server name to `vim.lsp.enable()` list
4. Restart Neovim

### Formatters

Configured via Conform (`.config/nvim/lua/kxhuan/plugins/conform.lua`):
- **Python**: ruff (organize imports, fix, format)
- **JavaScript/TypeScript**: prettierd
- **Lua**: stylua
- **Shell**: shfmt
- **Web**: prettierd (HTML, CSS, JSON, YAML, Markdown)

Format with: `<leader>gf` in normal or visual mode

### Key Bindings

Leader key: `<space>` (default)

**File Navigation**:
- `<leader>ee`: Toggle file explorer (nvim-tree)
- `<leader>ef`: Toggle file explorer on current file
- `<leader>ff`: Fuzzy find files
- `<leader>fr`: Recent files
- `<leader>fs`: Live grep in cwd
- `<leader>fc`: Find string under cursor

**LSP** (buffer-local, only active when LSP is attached):
- `gd`: Go to definition
- `gD`: Go to declaration
- `gr`: Show LSP references (Telescope)
- `gi`: Go to implementation
- `ga`: Code action
- `<leader>rn`: Rename symbol
- `<leader>ws`: Search workspace symbols
- `<leader>ds`: Search document symbols

Note: LSP keymaps are set via `LspAttach` autocmd, preventing errors on files without LSP support.

**Debugging (DAP)**:
- `<F5>`: Continue
- `<F6>`: Terminate
- `<F9>`: Toggle breakpoint
- `<F10>`: Step over
- `<F11>`: Step into
- `<F12>`: Step out

**Window Management**:
- `<leader>sv`: Split vertically
- `<leader>sh`: Split horizontally
- `<leader>se`: Make splits equal size
- `<leader>sx`: Close current split
- `<C-h/j/k/l>`: Navigate splits (vim-tmux-navigator integration)

**Tabs**:
- `<leader>to`: Open new tab
- `<leader>tx`: Close tab
- `<leader>tn/tp`: Next/previous tab

**Git**:
- `<leader>gb`: Show git blame for current line

### DAP Configuration

Located in `.config/nvim/lua/kxhuan/plugins/dap.lua`:

**Python Debugging**:
- Uses `debugpy` adapter
- Automatically detects virtualenv Python (`$VIRTUAL_ENV/bin/python3`)
- Preset configuration: "Pytest: Current File" runs pytest on active file with logging

**C/C++ Debugging**:
- Uses GDB adapter
- Configurations: Launch, Attach to process, Attach to gdbserver
- VSCode launch.json auto-loading from `.vscode/launch.json` or `.vscode_shared/launch.json`

## Zsh Configuration

### Location and Structure

Configuration root: `.config/zsh/` (set via `$ZDOTDIR`)

Modular files loaded by `.zshrc`:
- `zsh-functions`: Helper functions for plugin management
- `zsh-exports`: Environment variables and PATH configuration
- `zsh-vim-mode`: Vim keybindings in shell
- `zsh-aliases`: Command aliases
- `zsh-prompt`: Custom prompt configuration

### Plugins

Auto-installed via `zsh_add_plugin` function (clones from GitHub):
- `zsh-users/zsh-autosuggestions`: Command suggestions
- `zsh-users/zsh-syntax-highlighting`: Syntax highlighting
- `hlissner/zsh-autopair`: Auto-close brackets/quotes

Located in `.config/zsh/plugins/`

### Key Settings

- **Editor**: nvim (set as `$EDITOR`)
- **History**: 1,000,000 lines
- **FZF**: Integrated with platform-specific paths (Ubuntu, Fedora, Homebrew)
- **Direnv**: Enabled via hook

### Important Aliases

- `vim=nvim`
- `nvimrc`: Edit Neovim config
- `g=lazygit`
- `m/s`: Checkout master/stable branches

## Tmux Configuration

Located in `tmux/.tmux.conf`

### Key Features

- **Prefix**: `Ctrl-a` (rebind from default `Ctrl-b`)
- **Vim integration**: Smart pane navigation with vim-tmux-navigator
  - `<C-h/j/k/l>`: Navigate between tmux panes and vim splits seamlessly
- **Vi mode**: Copy mode uses vi keybindings
- **Clipboard**: System clipboard integration via xclip
- **Colors**: True color support (24-bit)
- **History**: 200,000 lines

### Copy Mode Bindings

- `v`: Begin selection
- `y`: Copy to clipboard (xclip)
- `C-v`: Rectangle toggle

### Layout Switching

Quick layout changes with Alt+Number:
- `M-1`: even-horizontal (columns of equal width)
- `M-2`: even-vertical (rows of equal height)
- `M-3`: main-horizontal (large pane on top)
- `M-4`: main-vertical (large pane on left)
- `M-5`: tiled (grid layout)

## Development Workflow

### Adding New Neovim Plugins

1. Create a new file in `.config/nvim/lua/kxhuan/plugins/` or add to existing
2. Return a lazy.nvim spec table:
   ```lua
   return {
     "author/plugin-name",
     config = function()
       -- Setup code
     end
   }
   ```
3. Restart Neovim - lazy.nvim auto-loads from `kxhuan.plugins` import

### Modifying Zsh Configuration

Edit the appropriate modular file in `.config/zsh/`:
- Aliases → `zsh-aliases`
- Exports/PATH → `zsh-exports`
- Functions → `zsh-functions`
- Prompt → `zsh-prompt`

Reload: `source ~/.config/zsh/.zshrc`

### Working with Different Operating Systems

When modifying installation scripts:
- Test OS detection in `bootstrap.sh`
- Add platform-specific logic using conditionals:
  ```bash
  if [ -f /etc/fedora-release ]; then
      # Fedora
  elif [ -f /etc/lsb-release ]; then
      # Ubuntu
  elif [[ "$OSTYPE" == "darwin"* ]]; then
      # macOS
  fi
  ```

## Troubleshooting

### Neovim Python Provider

If `:checkhealth` shows outdated pynvim:
```bash
python3 -m pip install --user --upgrade pynvim
```

This updates the Python provider used by Neovim plugins. The user installation (`~/.local/lib/python3.*/site-packages/`) takes precedence over system packages.

The Python host is configured in `.config/nvim/lua/kxhuan/core/options.lua` to automatically detect and use:
- The virtualenv's Python if `$VIRTUAL_ENV` is set
- The system Python found in PATH otherwise

If working in a virtualenv, ensure pynvim is installed in that environment:
```bash
pip install pynvim
```

## Notes

- The configuration assumes installation at `$HOME/devcfg/`
- Zsh config references this path: `ZDOTDIR=$HOME/devcfg/.config/zsh`
- Neovim uses standard XDG paths for data (`~/.local/share/nvim/`)
- Some macOS-specific paths remain in zsh config (`.zshrc` line 97) for compatibility
