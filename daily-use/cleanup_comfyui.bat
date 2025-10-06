@echo off
echo ================================================
echo ComfyUI クリーンアップスクリプト
echo ================================================
echo.
echo 何をクリーンアップしますか?
echo 1. 一時ファイルとキャッシュのみ
echo 2. 生成された画像/動画のみ
echo 3. 完全アンインストール(ComfyUI全体を削除)
echo.
set /p CLEANUP_MODE="選択 (1-3): "

set INSTALL_DIR=%~dp0..\ComfyUI

if not exist "%INSTALL_DIR%" (
    echo [エラー] ComfyUIがインストールされていません
    pause
    exit /b 1
)

if "%CLEANUP_MODE%"=="1" goto CACHE
if "%CLEANUP_MODE%"=="2" goto OUTPUT
if "%CLEANUP_MODE%"=="3" goto FULL
echo 無効な選択です
pause
exit /b 1

:CACHE
echo 一時ファイルを削除中...
cd /d "%INSTALL_DIR%"
if exist "temp" rd /s /q temp
if exist "__pycache__" rd /s /q __pycache__
if exist "venv\Lib\site-packages\*.pyc" del /s /q "venv\Lib\site-packages\*.pyc"
echo キャッシュを削除しました
goto END

:OUTPUT
echo 生成ファイルを削除中...
cd /d "%INSTALL_DIR%"
if exist "output" (
    set /p CONFIRM="outputフォルダを削除しますか? (Y/N): "
    if /i "%CONFIRM%"=="Y" (
        rd /s /q output
        mkdir output
        echo 生成ファイルを削除しました
    )
)
goto END

:FULL
echo.
echo [警告] ComfyUI全体が削除されます
echo モデルファイルも削除されます(約5GB×モデル数)
echo.
set /p CONFIRM="本当に削除しますか? (YES と入力): "
if "%CONFIRM%"=="YES" (
    cd /d "%~dp0"
    rd /s /q "%INSTALL_DIR%"
    del run_comfyui.bat 2>nul
    echo ComfyUIを完全に削除しました
) else (
    echo キャンセルされました
)
goto END

:END
echo.
pause
