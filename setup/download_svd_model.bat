@echo off
chcp 65001 >nul

REM スクリプトのディレクトリに移動
cd /d "%~dp0"

echo ================================================
echo SVDモデル自動ダウンロードスクリプト
echo ================================================
echo.

set INSTALL_DIR=%~dp0..\ComfyUI
set MODELS_DIR=%INSTALL_DIR%\models\checkpoints

REM ComfyUIの存在確認
if not exist "%INSTALL_DIR%" (
    echo [エラー] ComfyUIがインストールされていません
    echo 先にsetup_comfyui_svd.batを実行してください
    pause
    exit /b 1
)

cd /d "%INSTALL_DIR%"
if not exist venv\Scripts\activate.bat (
    echo [エラー] 仮想環境が見つかりません
    pause
    exit /b 1
)

call venv\Scripts\activate.bat
if %errorLevel% neq 0 (
    echo [エラー] 仮想環境のアクティベートに失敗しました
    pause
    exit /b 1
)

echo [1/3] Hugging Face CLIのインストール...
pip install -U huggingface-hub
if %errorLevel% neq 0 (
    echo [エラー] Hugging Face CLIのインストールに失敗しました
    pause
    exit /b 1
)
echo.

REM 引数チェック: AUTOが渡された場合は自動的にSVD-XT(1)を選択
if /i "%~1"=="AUTO" (
    set MODEL_CHOICE=1
    echo [自動選択] SVD-XT (25フレーム, 推奨)
    echo.
) else (
    echo モデルを選択してください:
    echo 1. SVD-XT (25フレーム, 推奨) - VRAM 12-15GB必要
    echo 2. SVD (14フレーム) - VRAM 10-12GB必要
    echo 3. 両方ダウンロード
    echo.
    set /p MODEL_CHOICE="選択 (1/2/3): "
)

if "%MODEL_CHOICE%"=="1" goto DOWNLOAD_XT
if "%MODEL_CHOICE%"=="2" goto DOWNLOAD_NORMAL
if "%MODEL_CHOICE%"=="3" goto DOWNLOAD_BOTH
echo 無効な選択です
pause
exit /b 1

:DOWNLOAD_XT
echo [2/3] SVD-XT (25フレーム) をダウンロード中...
huggingface-cli download stabilityai/stable-video-diffusion-img2vid-xt svd_xt.safetensors --local-dir "%MODELS_DIR%" --local-dir-use-symlinks False
if %errorLevel% neq 0 (
    echo [エラー] モデルのダウンロードに失敗しました
    pause
    exit /b 1
)
goto COMPLETE

:DOWNLOAD_NORMAL
echo [2/3] SVD (14フレーム) をダウンロード中...
huggingface-cli download stabilityai/stable-video-diffusion-img2vid svd.safetensors --local-dir "%MODELS_DIR%" --local-dir-use-symlinks False
if %errorLevel% neq 0 (
    echo [エラー] モデルのダウンロードに失敗しました
    pause
    exit /b 1
)
goto COMPLETE

:DOWNLOAD_BOTH
echo [2/3] 両方のモデルをダウンロード中...
echo SVD-XTをダウンロード中...
huggingface-cli download stabilityai/stable-video-diffusion-img2vid-xt svd_xt.safetensors --local-dir "%MODELS_DIR%" --local-dir-use-symlinks False
if %errorLevel% neq 0 (
    echo [エラー] SVD-XTのダウンロードに失敗しました
    pause
    exit /b 1
)
echo SVDをダウンロード中...
huggingface-cli download stabilityai/stable-video-diffusion-img2vid svd.safetensors --local-dir "%MODELS_DIR%" --local-dir-use-symlinks False
if %errorLevel% neq 0 (
    echo [エラー] SVDのダウンロードに失敗しました
    pause
    exit /b 1
)
goto COMPLETE

:COMPLETE
echo.
echo [3/3] ダウンロード完了！
echo.
echo モデルの配置場所: %MODELS_DIR%
echo.
dir /b "%MODELS_DIR%\*.safetensors"
echo.
echo ComfyUIを起動してください: daily-use\run_comfyui_advanced.bat
pause
