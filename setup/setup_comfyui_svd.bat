@echo off
echo ================================================
echo ComfyUI + Stable Video Diffusion 自動セットアップ
echo ================================================
echo.

REM 管理者権限チェック
net session >nul 2>&1
if %errorLevel% neq 0 (
    echo [警告] 管理者権限で実行することを推奨します
    echo 右クリック → 管理者として実行
    pause
)

REM インストール用ディレクトリ
set INSTALL_DIR=%~dp0..\ComfyUI
set MODELS_DIR=%INSTALL_DIR%\models\checkpoints
set CUSTOM_NODES_DIR=%INSTALL_DIR%\custom_nodes

echo [1/8] Python 3.11 の確認...
py --version >nul 2>&1
if %errorLevel% neq 0 (
    python --version >nul 2>&1
    if %errorLevel% neq 0 (
        echo [エラー] Pythonがインストールされていません
        echo https://www.python.org/downloads からダウンロードしてください
        pause
        exit /b 1
    )
    set PYTHON_CMD=python
) else (
    set PYTHON_CMD=py
)

%PYTHON_CMD% --version
echo Python OK!
echo.

echo [2/8] Gitの確認...
git --version >nul 2>&1
if %errorLevel% neq 0 (
    echo [エラー] Gitがインストールされていません
    echo https://git-scm.com/download/win からダウンロードしてください
    pause
    exit /b 1
)
git --version
echo Git OK!
echo.

echo [3/8] ComfyUIのクローン...
if exist "%INSTALL_DIR%" (
    echo ComfyUIフォルダが既に存在します。スキップします。
) else (
    git clone https://github.com/comfyanonymous/ComfyUI.git "%INSTALL_DIR%"
    if %errorLevel% neq 0 (
        echo [エラー] ComfyUIのクローンに失敗しました
        pause
        exit /b 1
    )
)
echo.

echo [4/8] 仮想環境の作成...
cd /d "%INSTALL_DIR%"
if not exist venv (
    %PYTHON_CMD% -m venv venv
    if %errorLevel% neq 0 (
        echo [エラー] 仮想環境の作成に失敗しました
        pause
        exit /b 1
    )
    echo 仮想環境を作成しました
) else (
    echo 仮想環境が既に存在します
)
echo.

echo [5/8] 依存関係のインストール...
call venv\Scripts\activate.bat
if %errorLevel% neq 0 (
    echo [エラー] 仮想環境のアクティベートに失敗しました
    pause
    exit /b 1
)
echo pipをアップグレード中...
python -m pip install --upgrade pip
echo PyTorchをインストール中...
python -m pip install torch torchvision torchaudio --index-url https://download.pytorch.org/whl/cu124
echo 依存関係をインストール中...
python -m pip install -r requirements.txt
if %errorLevel% neq 0 (
    echo [警告] 一部の依存関係のインストールに失敗しましたが、続行します
)
echo.

echo [6/8] SVD用カスタムノードのインストール...
if not exist "%CUSTOM_NODES_DIR%\ComfyUI-Stable-Video-Diffusion" (
    cd /d "%CUSTOM_NODES_DIR%"
    git clone https://github.com/thecooltechguy/ComfyUI-Stable-Video-Diffusion
    cd ComfyUI-Stable-Video-Diffusion
    python -m pip install -r requirements.txt
    echo SVDノードをインストールしました
) else (
    echo SVDノードが既に存在します
)
echo.

echo [7/8] modelsフォルダの作成...
if not exist "%MODELS_DIR%" (
    mkdir "%MODELS_DIR%"
)
echo.

echo [8/8] セットアップ完了確認...
cd /d "%INSTALL_DIR%"
echo.
echo ================================================
echo セットアップが完了しました！
echo ================================================
echo.
echo 次のステップ:
echo 1. SVDモデルをダウンロード
echo    https://huggingface.co/stabilityai/stable-video-diffusion-img2vid-xt
echo.
echo 2. ダウンロードしたsvd_xt.safetensorsを以下に配置
echo    %MODELS_DIR%
echo.
echo 3. ComfyUIを起動
echo    daily-use\run_comfyui_advanced.bat をダブルクリック
echo.
pause

REM 起動用バッチファイルを作成
if not exist "%~dp0..\daily-use" (
    mkdir "%~dp0..\daily-use"
)
cd /d "%~dp0..\daily-use"
(
echo @echo off
echo cd /d "%%~dp0.."
echo call ComfyUI\venv\Scripts\activate.bat
echo cd ComfyUI
echo python main.py
echo pause
) > run_comfyui.bat

echo.
echo [補足] daily-use\run_comfyui.bat を作成しました
echo このファイルをダブルクリックでComfyUIを起動できます
echo.
pause
