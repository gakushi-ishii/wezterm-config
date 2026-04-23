# Copilot プロジェクト指示

このリポジトリは Windows ホスト上の WezTerm ターミナル設定を管理しています。

## プロジェクト構成

- `wezterm/wezterm.lua` - メインの WezTerm 設定ファイル
- `wezterm/appearance.lua` - 外観（カラースキーム・フォント・ウィンドウ）設定
- `wezterm/keys.lua` - キーバインド設定
- `wezterm/launch.lua` - 起動プログラム・WSL・tmux 設定
- `setup.ps1` - Windows へのシンボリックリンクセットアップ

## 環境コンテキスト

- OS: Windows（WezTerm は Windows にインストール済み）
- WSL: Ubuntu が利用可能（default_prog で WSL を起動）
- 設定ファイルの実際のパス: `%USERPROFILE%/.config/wezterm/wezterm.lua`
- セットアップ後、`wezterm/` ディレクトリが上記パスにシンボリックリンクされる

## 設定変更時のルール

1. WezTerm の設定は Lua で記述する
2. `wezterm.config_builder()` を使用する
3. 設定はモジュール化されている（appearance.lua, keys.lua, launch.lua）
4. 変更後は WezTerm が自動リロードする（CTRL+SHIFT+R で手動も可）
5. 日本語入力のため `use_ime = true` は必須
