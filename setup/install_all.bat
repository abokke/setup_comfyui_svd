@echo off
chcp 65001 >nul
cls
echo ================================================
echo ComfyUI + SVD ワンクリックインストーラー
echo ================================================
echo.
echo このスクリプトは以下を自動実行します:
echo 1. ComfyUIのインストール
echo 2. SVDカスタムノードのインストール
echo 3. SVDモデルのダウンロード
echo 4. 起動スクリプトの作成
echo.
echo 所要時間: 約20-30分（ネット速度による）
echo 必要容量: 約15GB
echo.
set /p START="開始しますか？ (Y/N): "
if /i not "%START%"=="Y" exit /b

REM ステップ1: 基本セットアップ
call setup_comfyui_svd.bat
if %errorLevel% neq 0 (
    echo [エラー] セットアップに失敗しました
    pause
    exit /b 1
)

REM ステップ2: モデルダウンロード
call download_svd_model.bat
if %errorLevel% neq 0 (
    echo [エラー] モデルのダウンロードに失敗しました
    pause
    exit /b 1
)

echo.
echo ================================================
echo インストール完了！
echo ================================================
echo.
echo 今すぐComfyUIを起動しますか？
set /p LAUNCH="起動する (Y/N): "
if /i "%LAUNCH%"=="Y" (
    call run_comfyui.bat
)