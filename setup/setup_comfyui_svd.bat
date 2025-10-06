@echo off
echo ================================================
echo ComfyUI + Stable Video Diffusion �����Z�b�g�A�b�v
echo ================================================
echo.

REM �Ǘ��Ҍ����`�F�b�N
net session >nul 2>&1
if %errorLevel% neq 0 (
    echo [�x��] �Ǘ��Ҍ����Ŏ��s���邱�Ƃ𐄏����܂�
    echo �E�N���b�N �� �Ǘ��҂Ƃ��Ď��s
    pause
)

REM �C���X�g�[���p�f�B���N�g��
set INSTALL_DIR=%~dp0..\ComfyUI
set MODELS_DIR=%INSTALL_DIR%\models\checkpoints
set CUSTOM_NODES_DIR=%INSTALL_DIR%\custom_nodes

echo [1/8] Python 3.11 �̊m�F...
py --version >nul 2>&1
if %errorLevel% neq 0 (
    python --version >nul 2>&1
    if %errorLevel% neq 0 (
        echo [�G���[] Python���C���X�g�[������Ă��܂���
        echo https://www.python.org/downloads ����_�E�����[�h���Ă�������
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

echo [2/8] Git�̊m�F...
git --version >nul 2>&1
if %errorLevel% neq 0 (
    echo [�G���[] Git���C���X�g�[������Ă��܂���
    echo https://git-scm.com/download/win ����_�E�����[�h���Ă�������
    pause
    exit /b 1
)
git --version
echo Git OK!
echo.

echo [3/8] ComfyUI�̃N���[��...
if exist "%INSTALL_DIR%" (
    echo ComfyUI�t�H���_�����ɑ��݂��܂��B�X�L�b�v���܂��B
) else (
    git clone https://github.com/comfyanonymous/ComfyUI.git "%INSTALL_DIR%"
    if %errorLevel% neq 0 (
        echo [�G���[] ComfyUI�̃N���[���Ɏ��s���܂���
        pause
        exit /b 1
    )
)
echo.

echo [4/8] ���z���̍쐬...
cd /d "%INSTALL_DIR%"
if not exist venv (
    %PYTHON_CMD% -m venv venv
    if %errorLevel% neq 0 (
        echo [�G���[] ���z���̍쐬�Ɏ��s���܂���
        pause
        exit /b 1
    )
    echo ���z�����쐬���܂���
) else (
    echo ���z�������ɑ��݂��܂�
)
echo.

echo [5/8] �ˑ��֌W�̃C���X�g�[��...
call venv\Scripts\activate.bat
if %errorLevel% neq 0 (
    echo [�G���[] ���z���̃A�N�e�B�x�[�g�Ɏ��s���܂���
    pause
    exit /b 1
)
echo pip���A�b�v�O���[�h��...
python -m pip install --upgrade pip
echo PyTorch���C���X�g�[����...
python -m pip install torch torchvision torchaudio --index-url https://download.pytorch.org/whl/cu124
echo �ˑ��֌W���C���X�g�[����...
python -m pip install -r requirements.txt
if %errorLevel% neq 0 (
    echo [�x��] �ꕔ�̈ˑ��֌W�̃C���X�g�[���Ɏ��s���܂������A���s���܂�
)
echo.

echo [6/8] SVD�p�J�X�^���m�[�h�̃C���X�g�[��...
if not exist "%CUSTOM_NODES_DIR%\ComfyUI-Stable-Video-Diffusion" (
    cd /d "%CUSTOM_NODES_DIR%"
    git clone https://github.com/thecooltechguy/ComfyUI-Stable-Video-Diffusion
    cd ComfyUI-Stable-Video-Diffusion
    python -m pip install -r requirements.txt
    echo SVD�m�[�h���C���X�g�[�����܂���
) else (
    echo SVD�m�[�h�����ɑ��݂��܂�
)
echo.

echo [7/8] models�t�H���_�̍쐬...
if not exist "%MODELS_DIR%" (
    mkdir "%MODELS_DIR%"
)
echo.

echo [8/8] �Z�b�g�A�b�v�����m�F...
cd /d "%INSTALL_DIR%"
echo.
echo ================================================
echo �Z�b�g�A�b�v���������܂����I
echo ================================================
echo.
echo ���̃X�e�b�v:
echo 1. SVD���f�����_�E�����[�h
echo    https://huggingface.co/stabilityai/stable-video-diffusion-img2vid-xt
echo.
echo 2. �_�E�����[�h����svd_xt.safetensors���ȉ��ɔz�u
echo    %MODELS_DIR%
echo.
echo 3. ComfyUI���N��
echo    daily-use\run_comfyui_advanced.bat ���_�u���N���b�N
echo.
pause

REM �N���p�o�b�`�t�@�C�����쐬
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
echo [�⑫] daily-use\run_comfyui.bat ���쐬���܂���
echo ���̃t�@�C�����_�u���N���b�N��ComfyUI���N���ł��܂�
echo.
pause
