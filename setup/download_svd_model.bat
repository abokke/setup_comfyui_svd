@echo off

REM �X�N���v�g�̃f�B���N�g���Ɉړ�
cd /d "%~dp0"

echo ================================================
echo SVD���f�������_�E�����[�h�X�N���v�g
echo ================================================
echo.

set INSTALL_DIR=%~dp0..\ComfyUI
set MODELS_DIR=%INSTALL_DIR%\models\checkpoints

REM ComfyUI�̑��݊m�F
if not exist "%INSTALL_DIR%" (
    echo [�G���[] ComfyUI���C���X�g�[������Ă��܂���
    echo ���setup_comfyui_svd.bat�����s���Ă�������
    pause
    exit /b 1
)

if not exist "%INSTALL_DIR%\venv\Scripts\activate.bat" (
    echo [�G���[] ���z����������܂���
    pause
    exit /b 1
)

cd /d "%INSTALL_DIR%"
set PYTHON_EXE=%INSTALL_DIR%\venv\Scripts\python.exe

echo [1/3] Hugging Face CLI�̃C���X�g�[��...
"%PYTHON_EXE%" -m pip install -U huggingface-hub
if %errorLevel% neq 0 (
    echo.
    echo [�G���[] Hugging Face CLI�̃C���X�g�[���Ɏ��s���܂���
    echo �G���[�R�[�h: %errorLevel%
    pause
    exit /b 1
)
echo.

REM �����`�F�b�N: AUTO���n���ꂽ�ꍇ�͎����I��SVD-XT(1)��I��
if /i "%~1"=="AUTO" (
    set MODEL_CHOICE=1
    echo [�����I��] SVD-XT 25�t���[�� ��
    echo.
    goto PROCESS_CHOICE
) else (
    echo ���f����I�����Ă�������:
    echo 1. SVD-XT 25�t���[�� �� - VRAM 12-15GB�K�v
    echo 2. SVD 14�t���[�� - VRAM 10-12GB�K�v
    echo 3. �����_�E�����[�h
    echo.
    set /p MODEL_CHOICE="�I�� (1/2/3): "
)

:PROCESS_CHOICE

if "%MODEL_CHOICE%"=="1" goto DOWNLOAD_XT
if "%MODEL_CHOICE%"=="2" goto DOWNLOAD_NORMAL
if "%MODEL_CHOICE%"=="3" goto DOWNLOAD_BOTH
echo �����ȑI���ł�
pause
exit /b 1

:DOWNLOAD_XT
echo [2/3] SVD-XT 25�t���[�� �Ń_�E�����[�h��...
"%PYTHON_EXE%" -c "from huggingface_hub import hf_hub_download; hf_hub_download(repo_id='stabilityai/stable-video-diffusion-img2vid-xt', filename='svd_xt.safetensors', local_dir='%MODELS_DIR%', local_dir_use_symlinks=False)"
if %errorLevel% neq 0 (
    echo [�G���[] ���f���̃_�E�����[�h�Ɏ��s���܂���
    pause
    exit /b 1
)
goto COMPLETE

:DOWNLOAD_NORMAL
echo [2/3] SVD 14�t���[�� �Ń_�E�����[�h��...
"%PYTHON_EXE%" -c "from huggingface_hub import hf_hub_download; hf_hub_download(repo_id='stabilityai/stable-video-diffusion-img2vid', filename='svd.safetensors', local_dir='%MODELS_DIR%', local_dir_use_symlinks=False)"
if %errorLevel% neq 0 (
    echo [�G���[] ���f���̃_�E�����[�h�Ɏ��s���܂���
    pause
    exit /b 1
)
goto COMPLETE

:DOWNLOAD_BOTH
echo [2/3] �����̃��f�����_�E�����[�h��...
echo SVD-XT���_�E�����[�h��...
"%PYTHON_EXE%" -c "from huggingface_hub import hf_hub_download; hf_hub_download(repo_id='stabilityai/stable-video-diffusion-img2vid-xt', filename='svd_xt.safetensors', local_dir='%MODELS_DIR%', local_dir_use_symlinks=False)"
if %errorLevel% neq 0 (
    echo [�G���[] SVD-XT�̃_�E�����[�h�Ɏ��s���܂���
    pause
    exit /b 1
)
echo SVD���_�E�����[�h��...
"%PYTHON_EXE%" -c "from huggingface_hub import hf_hub_download; hf_hub_download(repo_id='stabilityai/stable-video-diffusion-img2vid', filename='svd.safetensors', local_dir='%MODELS_DIR%', local_dir_use_symlinks=False)"
if %errorLevel% neq 0 (
    echo [�G���[] SVD�̃_�E�����[�h�Ɏ��s���܂���
    pause
    exit /b 1
)
goto COMPLETE

:COMPLETE
echo.
echo [3/3] �_�E�����[�h����
echo.
echo ���f���̔z�u�ꏊ: %MODELS_DIR%
echo.
dir /b "%MODELS_DIR%\*.safetensors"
echo.
echo ComfyUI���N�����Ă�������: daily-use\run_comfyui_advanced.bat
pause
