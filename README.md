# zoxide.nvim

Minimal single-file Neovim wrapper around [zoxide](https://github.com/ajeetdsouza/zoxide).

## Requirements

- [neovim](https://github.com/neovim/neovim) 0.7+
- [zoxide](https://github.com/ajeetdsouza/zoxide) installed

## Installation

**lazy.nvim:**
```lua
{
  "n1kica/zoxide.nvim",
  cmd = "Z",
  opts = {}
}
```

## Usage

```vim
:Z <query>
```

Changes Neovim working directory using zoxide's database of frequently used directories.

## Examples

```vim
:Z nvim
:Z User downl
```
