@echo off
echo ================================================
echo ComfyUI 起動オプション
echo ================================================
echo.
echo 起動モードを選択してください:
echo 1. 通常起動 (12GB以上のVRAM推奨)
echo 2. 低VRAMモード (8-12GB VRAM)
echo 3. 超低VRAMモード (6-8GB VRAM)
echo 4. CPUモード (GPUなし、非常に遅い)
echo 5. ポート変更モード (デフォルト: 8188)
echo.
set /p LAUNCH_MODE="選択 (1-5): "

set INSTALL_DIR=%~dp0..\ComfyUI
if not exist "%INSTALL_DIR%" (
    echo [エラー] ComfyUIがインストールされていません
    pause
    exit /b 1
)
set PYTHON_EXE=%INSTALL_DIR%\venv\Scripts\python.exe
cd /d "%INSTALL_DIR%"

if %LAUNCH_MODE%==1 goto NORMAL
if %LAUNCH_MODE%==2 goto LOWVRAM
if %LAUNCH_MODE%==3 goto NOVRAM
if %LAUNCH_MODE%==4 goto CPU
if %LAUNCH_MODE%==5 goto PORT
echo 無効な選択です
pause
exit /b 1

:NORMAL
echo 通常モードで起動中...
start http://127.0.0.1:8188
"%PYTHON_EXE%" main.py
goto END

:LOWVRAM
echo 低VRAMモードで起動中...
start http://127.0.0.1:8188
"%PYTHON_EXE%" main.py --lowvram
goto END

:NOVRAM
echo 超低VRAMモードで起動中...
start http://127.0.0.1:8188
"%PYTHON_EXE%" main.py --novram
goto END

:CPU
echo CPUモードで起動中(非常に遅いです)...
start http://127.0.0.1:8188
"%PYTHON_EXE%" main.py --cpu
goto END

:PORT
echo.
set /p CUSTOM_PORT="ポート番号を入力 (例: 8080): "
echo ポート %CUSTOM_PORT% で起動中...
start http://127.0.0.1:%CUSTOM_PORT%
"%PYTHON_EXE%" main.py --port %CUSTOM_PORT%
goto END

:END
pause
