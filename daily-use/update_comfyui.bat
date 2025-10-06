@echo off
echo ================================================
echo ComfyUI + SVD�m�[�h �A�b�v�f�[�g�X�N���v�g
echo ================================================
echo.

set INSTALL_DIR=%~dp0..\ComfyUI
set CUSTOM_NODES_DIR=%INSTALL_DIR%\custom_nodes

if not exist "%INSTALL_DIR%" (
    echo [�G���[] ComfyUI���C���X�g�[������Ă��܂���
    pause
    exit /b 1
)

echo [1/3] ComfyUI�{�̂��X�V��...
cd /d "%INSTALL_DIR%"
git pull
if %errorLevel% neq 0 (
    echo [�x��] ComfyUI�̍X�V�Ɏ��s���܂���
)
echo.

echo [2/3] �ˑ��֌W���X�V��...
call venv\Scripts\activate.bat
python -m pip install --upgrade pip
python -m pip install -r requirements.txt --upgrade
echo.

echo [3/3] SVD�J�X�^���m�[�h���X�V��...
cd /d "%CUSTOM_NODES_DIR%\ComfyUI-Stable-Video-Diffusion"
git pull
if %errorLevel% neq 0 (
    echo [�x��] SVD�m�[�h�̍X�V�Ɏ��s���܂���
) else (
    python -m pip install -r requirements.txt --upgrade
)
echo.

echo ================================================
echo �A�b�v�f�[�g����!
echo ================================================
echo.
pause
