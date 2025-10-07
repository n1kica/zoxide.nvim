# zoxide.nvim

Neovim plugin for [zoxide](https://github.com/ajeetdsouza/zoxide) integration.

## Requirements

- Neovim 0.5+
- [zoxide](https://github.com/ajeetdsouza/zoxide) installed

## Installation

**lazy.nvim:**
```lua
{
  "n1kica/zoxide.nvim",
  opts = {}
}
```

## Usage

```vim
:Z <query>
```

Changes the current working directory using zoxide's database of frequently used directories.

## Examples

```vim
:Z nvim
:Z Docu
```
