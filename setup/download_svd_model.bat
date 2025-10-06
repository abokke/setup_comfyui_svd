@echo off

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

if not exist "%INSTALL_DIR%\venv\Scripts\activate.bat" (
    echo [エラー] 仮想環境が見つかりません
    pause
    exit /b 1
)

cd /d "%INSTALL_DIR%"
set PYTHON_EXE=%INSTALL_DIR%\venv\Scripts\python.exe

echo [1/3] Hugging Face CLIのインストール...
"%PYTHON_EXE%" -m pip install -U huggingface-hub
if %errorLevel% neq 0 (
    echo.
    echo [エラー] Hugging Face CLIのインストールに失敗しました
    echo エラーコード: %errorLevel%
    pause
    exit /b 1
)
echo.

REM 自動チェック: AUTOが渡された場合は自動的にSVD-XT(1)を選択
if /i "%~1"=="AUTO" (
    set MODEL_CHOICE=1
    echo [自動選択] SVD-XT 25フレーム 版
    echo.
    goto PROCESS_CHOICE
) else (
    echo モデルを選択してください:
    echo 1. SVD-XT 25フレーム 版 - VRAM 12-15GB必要
    echo 2. SVD 14フレーム - VRAM 10-12GB必要
    echo 3. 両方ダウンロード
    echo.
    set /p MODEL_CHOICE="選択 (1/2/3): "
)

:PROCESS_CHOICE

if "%MODEL_CHOICE%"=="1" goto DOWNLOAD_XT
if "%MODEL_CHOICE%"=="2" goto DOWNLOAD_NORMAL
if "%MODEL_CHOICE%"=="3" goto DOWNLOAD_BOTH
echo 無効な選択です
pause
exit /b 1

:DOWNLOAD_XT
echo [2/3] SVD-XT 25フレーム 版ダウンロード中...
"%PYTHON_EXE%" -c "from huggingface_hub import hf_hub_download; hf_hub_download(repo_id='stabilityai/stable-video-diffusion-img2vid-xt', filename='svd_xt.safetensors', local_dir='%MODELS_DIR%', local_dir_use_symlinks=False)"
if %errorLevel% neq 0 (
    echo [エラー] モデルのダウンロードに失敗しました
    pause
    exit /b 1
)
goto COMPLETE

:DOWNLOAD_NORMAL
echo [2/3] SVD 14フレーム 版ダウンロード中...
"%PYTHON_EXE%" -c "from huggingface_hub import hf_hub_download; hf_hub_download(repo_id='stabilityai/stable-video-diffusion-img2vid', filename='svd.safetensors', local_dir='%MODELS_DIR%', local_dir_use_symlinks=False)"
if %errorLevel% neq 0 (
    echo [エラー] モデルのダウンロードに失敗しました
    pause
    exit /b 1
)
goto COMPLETE

:DOWNLOAD_BOTH
echo [2/3] 両方のモデルをダウンロード中...
echo SVD-XTをダウンロード中...
"%PYTHON_EXE%" -c "from huggingface_hub import hf_hub_download; hf_hub_download(repo_id='stabilityai/stable-video-diffusion-img2vid-xt', filename='svd_xt.safetensors', local_dir='%MODELS_DIR%', local_dir_use_symlinks=False)"
if %errorLevel% neq 0 (
    echo [エラー] SVD-XTのダウンロードに失敗しました
    pause
    exit /b 1
)
echo SVDをダウンロード中...
"%PYTHON_EXE%" -c "from huggingface_hub import hf_hub_download; hf_hub_download(repo_id='stabilityai/stable-video-diffusion-img2vid', filename='svd.safetensors', local_dir='%MODELS_DIR%', local_dir_use_symlinks=False)"
if %errorLevel% neq 0 (
    echo [エラー] SVDのダウンロードに失敗しました
    pause
    exit /b 1
)
goto COMPLETE

:COMPLETE
echo.
echo [3/3] ダウンロード完了
echo.
echo モデルの配置場所: %MODELS_DIR%
echo.
dir /b "%MODELS_DIR%\*.safetensors"
echo.
echo ComfyUIを起動してください: daily-use\run_comfyui_advanced.bat
pause
