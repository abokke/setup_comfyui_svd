# ComfyUI + SVD セットアップツール集

このフォルダには、ComfyUI（Stable Video Diffusion対応）のセットアップと日常使用のためのスクリプトが含まれています。

## 📁 フォルダ構成

### setup/ - 初回セットアップ用
1回だけ実行するインストール・設定用スクリプト

- **setup_comfyui_svd.bat** - 基本セットアップ（Python/Git確認、ComfyUIインストール、仮想環境作成）
- **download_svd_model.bat** - SVDモデルの自動ダウンロード
- **install_all.bat** - ワンクリック統合インストーラー（全て自動実行）

### daily-use/ - 日常的に使用
日々の作業で使うスクリプト

- **run_comfyui.bat** - ComfyUI起動（シンプル版、ブラウザ自動起動）
- **run_comfyui_advanced.bat** - ComfyUI起動（VRAM設定選択可能、ブラウザ自動起動）
- **update_comfyui.bat** - ComfyUI本体とSVDノードの更新
- **cleanup_comfyui.bat** - キャッシュ削除/アンインストール

## 🚀 使い方

### 初回セットアップ
```
1. setup\install_all.bat を実行（推奨）
   または
   setup\setup_comfyui_svd.bat → setup\download_svd_model.bat の順に実行
```

### 日常使用
```
- 起動: daily-use\run_comfyui.bat（シンプル版）
       daily-use\run_comfyui_advanced.bat（詳細設定版）
- 更新: daily-use\update_comfyui.bat
- 削除: daily-use\cleanup_comfyui.bat
```

## ⚙️ システム要件
- Python 3.11以上
- Git
- CUDA対応GPU（推奨: VRAM 12GB以上）
- ディスク容量: 約15GB

## 📦 インストールされるもの
- ComfyUI本体
- Stable Video Diffusion カスタムノード
- PyTorch（CUDA 12.4対応）
- SVDモデル（オプション選択可能）

## 🎬 SVDモデルの選択肢

`download_svd_model.bat`では以下のモデルをダウンロードできます：

| モデル | フレーム数 | 必要VRAM | 特徴 |
|--------|-----------|----------|------|
| **SVD-XT** (推奨) | 25フレーム | 12-15GB | より長い動画生成が可能。デフォルト選択。 |
| **SVD** | 14フレーム | 10-12GB | 短めの動画生成。少ないVRAMで動作。 |
| **両方** | - | - | 用途に応じて使い分け可能。 |

- `install_all.bat`を使用すると、自動的にSVD-XT（25フレーム）がダウンロードされます
- VRAMが少ない場合は、個別に`download_svd_model.bat`を実行してSVD（14フレーム）を選択してください
