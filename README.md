# My AstroNvim configuration

**NOTE:** This is for AstroNvim v4+

This configuration was built upon the [default starting template](https://github.com/AstroNvim/template).

## 🛠️ Installation

### Isolated Installation

You can use an isolated installation environment, allowing you to keep using your own vim configuration alongside this config. To achieve this, you can simply clone this configuration to another location in `~/.config`, such as `~/.config/astronvim_itsdrike`.

```shell
git clone https://github.com/ItsDrike/AstroNvimUser ~/.config/astronvim_itsdrike
```

Once cloned, you can launch neovim with `NVIM_APPNAME=astronvim_itsdrike nvim`, which will use this configuration, while allowing you to keep using your own configuration by default.

On the first run, you might want to go with the unattended headless installation, by running: `NVIM_APPNAME=astronvim_itsdrike nvim --headless +q`, and only launch neovim once this completes.

### Regular installation

#### Make a backup of your current nvim and shared folder

```shell
mv ~/.config/nvim ~/.config/nvim.bak
mv ~/.local/share/nvim ~/.local/share/nvim.bak
mv ~/.local/state/nvim ~/.local/state/nvim.bak
mv ~/.cache/nvim ~/.cache/nvim.bak
```

#### Clone the repository

```shell
git clone https://github.com/ItsDrike/AstroNvimUser ~/.config/nvim
```

#### Run the unattended installation

```shell
nvim --headless +q
```

Wait until this finished before starting another instance of neovim. This will install all the plugins, mason toolings such as language servers and linters, treesitter parsers and anything else that needs installing.

#### Start Neovim

```shell
nvim
```
