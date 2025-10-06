@echo off
echo ================================================
echo ComfyUI �N���[���A�b�v�X�N���v�g
echo ================================================
echo.
echo �����N���[���A�b�v���܂���?
echo 1. �ꎞ�t�@�C���ƃL���b�V���̂�
echo 2. �������ꂽ�摜/����̂�
echo 3. ���S�A���C���X�g�[��(ComfyUI�S�̂��폜)
echo.
set /p CLEANUP_MODE="�I�� (1-3): "

set INSTALL_DIR=%~dp0..\ComfyUI

if not exist "%INSTALL_DIR%" (
    echo [�G���[] ComfyUI���C���X�g�[������Ă��܂���
    pause
    exit /b 1
)

if "%CLEANUP_MODE%"=="1" goto CACHE
if "%CLEANUP_MODE%"=="2" goto OUTPUT
if "%CLEANUP_MODE%"=="3" goto FULL
echo �����ȑI���ł�
pause
exit /b 1

:CACHE
echo �ꎞ�t�@�C�����폜��...
cd /d "%INSTALL_DIR%"
if exist "temp" rd /s /q temp
if exist "__pycache__" rd /s /q __pycache__
if exist "venv\Lib\site-packages\*.pyc" del /s /q "venv\Lib\site-packages\*.pyc"
echo �L���b�V�����폜���܂���
goto END

:OUTPUT
echo �����t�@�C�����폜��...
cd /d "%INSTALL_DIR%"
if exist "output" (
    set /p CONFIRM="output�t�H���_���폜���܂���? (Y/N): "
    if /i "%CONFIRM%"=="Y" (
        rd /s /q output
        mkdir output
        echo �����t�@�C�����폜���܂���
    )
)
goto END

:FULL
echo.
echo [�x��] ComfyUI�S�̂��폜����܂�
echo ���f���t�@�C�����폜����܂�(��5GB�~���f����)
echo.
set /p CONFIRM="�{���ɍ폜���܂���? (YES �Ɠ���): "
if "%CONFIRM%"=="YES" (
    cd /d "%~dp0"
    rd /s /q "%INSTALL_DIR%"
    del run_comfyui.bat 2>nul
    echo ComfyUI�����S�ɍ폜���܂���
) else (
    echo �L�����Z������܂���
)
goto END

:END
echo.
pause
