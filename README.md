# WezTerm Config

Windows ホスト上の WezTerm 設定を GitHub Copilot で管理するためのリポジトリです。

## 構成

```
wezterm-config/
├── .github/
│   ├── copilot-instructions.md   # Copilot プロジェクト指示
│   └── agents/
│       └── wezterm.md            # WezTerm カスタムエージェント
├── wezterm/
│   ├── wezterm.lua               # メイン設定ファイル
│   ├── appearance.lua            # 外観設定モジュール
│   ├── keys.lua                  # キーバインドモジュール
│   └── launch.lua                # 起動設定モジュール (WSL/tmux)
├── setup.ps1                     # Windows セットアップスクリプト
└── README.md
```

## セットアップ

### 1. Windows ホストで clone

```powershell
cd ~\repos
git clone https://github.com/<your-user>/wezterm-config.git
```

### 2. セットアップスクリプトを実行

PowerShell を**管理者権限**で開いて実行:

```powershell
cd ~\repos\wezterm-config
.\setup.ps1
```

これにより `wezterm/` 配下のファイルが `~/.config/wezterm/` にシンボリックリンクされます。

### 3. Copilot で設定を編集

```powershell
cd ~\repos\wezterm-config
ghcs   # または GitHub Copilot CLI を起動
```

`@wezterm` エージェントに設定変更を依頼できます。

## カスタムエージェントの使い方

```
@wezterm カラースキームを Catppuccin Mocha に変更して
@wezterm tmux を自動起動する設定を追加して
@wezterm フォントを HackGen に変更して
```
