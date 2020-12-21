## Tools install

## [linuxbrew](https://brew.sh/index_ja)

```sh
$ /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
$ echo 'eval $(/home/linuxbrew/.linuxbrew/bin/brew shellenv)' >> /home/tamago324/.zshrc
$ eval $(/home/linuxbrew/.linuxbrew/bin/brew shellenv)
```

```sh
$ brew install ghq \
               itchyny/tap/mmv \
               ripgrep \
               bat \
               fd \
               go \
               zsh
```


## [Neovim](https://github.com/neovim/neovim/releases/nightly)

```
$ wget https://github.com/neovim/neovim/releases/download/nightly/nvim.appimage
$ chmod u+x nvim.appimage
$ ./nvim.appimage
```
