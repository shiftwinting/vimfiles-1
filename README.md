# vimfiles

1.管理者権限で`cmd.exe`を起動し、以下のコマンドを実行する

```sh
ghq get tamago324/vimfiles
mklink /D %HOMEPATH%\vimfiles %HOMEPATH%\ghq\github.com\tamago324\vimfiles
```

> `%HOMEPATH%\ghq\github.com\tamago324\vimfiles`の部分はクローンしたパスによって変わる

2.[minpac](https://github.com/k-takata/minpac) をダウンロード

cmd を起動し、以下のコマンドを実行

```cmd
cd /d %USERPROFILE%
git clone https://github.com/k-takata/minpac.git vimfiles\pack\minpac\opt\minpac
```

3.セットアップ

vim を起動し、`:PackUpdate` を実行

4. 完了！
