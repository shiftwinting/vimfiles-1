# vimfiles

## neovim

```
$ ghq get tamago324/vimfiles
$ ln -s $GHQ_ROOT/github.com/tamago324/vimfiles $HOME/.config/nvim
```


## neovim build

```
make distclean
make CMAKE_BUILD_TYPE=RelWithDebInfo
sudo make install
```

`/usr/local/bin/nvim` に入る
