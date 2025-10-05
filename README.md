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

- **run_comfyui_advanced.bat** - ComfyUI起動（VRAM設定選択可能）
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
- 起動: daily-use\run_comfyui_advanced.bat
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
- PyTorch（CUDA 12.1対応）
- SVDモデル（オプション選択可能）
