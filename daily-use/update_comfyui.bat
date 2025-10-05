@echo off
chcp 65001 >nul
echo ================================================
echo ComfyUI + SVDノード アップデートスクリプト
echo ================================================
echo.

set INSTALL_DIR=%~dp0..\ComfyUI
set CUSTOM_NODES_DIR=%INSTALL_DIR%\custom_nodes

if not exist "%INSTALL_DIR%" (
    echo [エラー] ComfyUIがインストールされていません
    pause
    exit /b 1
)

echo [1/3] ComfyUI本体を更新中...
cd /d "%INSTALL_DIR%"
git pull
if %errorLevel% neq 0 (
    echo [警告] ComfyUIの更新に失敗しました
)
echo.

echo [2/3] 依存関係を更新中...
call venv\Scripts\activate.bat
python -m pip install --upgrade pip
python -m pip install -r requirements.txt --upgrade
echo.

echo [3/3] SVDカスタムノードを更新中...
cd /d "%CUSTOM_NODES_DIR%\ComfyUI-Stable-Video-Diffusion"
git pull
if %errorLevel% neq 0 (
    echo [警告] SVDノードの更新に失敗しました
) else (
    python -m pip install -r requirements.txt --upgrade
)
echo.

echo ================================================
echo アップデート完了！
echo ================================================
echo.
pause