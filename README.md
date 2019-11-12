# vimfiles

1. 管理者権限で`cmd.exe`を起動し、以下のコマンドを実行する

```sh
mklink /D %HOMEPATH%\vimfiles %HOMEPATH%\ghq\github.com\tamago324\vimfiles
```

> `%HOMEPATH%\ghq\github.com\tamago324\vimfiles`の部分はクローンしたパスによって変わる

2. vim-plug をダウンロード

powershell を起動し、以下のコマンドを実行

```sh
md ~\vimfiles\autoload
$uri = 'https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
(New-Object Net.WebClient).DownloadFile(
  $uri,
  $ExecutionContext.SessionState.Path.GetUnresolvedProviderPathFromPSPath(
    "~\vimfiles\autoload\plug.vim"
  )
)
```

3. セットアップ

vim を起動し、`:PlugInstall` を実行

エラーが出たら、Vim を再起動後、最後 `:PlugInstall` を実行

4. 完了！
