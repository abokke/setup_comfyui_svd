@echo off
echo ================================================
echo ComfyUI �N���I�v�V����
echo ================================================
echo.
echo �N�����[�h��I�����Ă�������:
echo 1. �ʏ�N�� (12GB�ȏ��VRAM����)
echo 2. ��VRAM���[�h (8-12GB VRAM)
echo 3. ����VRAM���[�h (6-8GB VRAM)
echo 4. CPU���[�h (GPU�Ȃ��A���ɒx��)
echo 5. �|�[�g�ύX���[�h (�f�t�H���g: 8188)
echo.
set /p LAUNCH_MODE="�I�� (1-5): "

set INSTALL_DIR=%~dp0..\ComfyUI
if not exist "%INSTALL_DIR%" (
    echo [�G���[] ComfyUI���C���X�g�[������Ă��܂���
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
echo �����ȑI���ł�
pause
exit /b 1

:NORMAL
echo �ʏ탂�[�h�ŋN����...
start http://127.0.0.1:8188
"%PYTHON_EXE%" main.py
goto END

:LOWVRAM
echo ��VRAM���[�h�ŋN����...
start http://127.0.0.1:8188
"%PYTHON_EXE%" main.py --lowvram
goto END

:NOVRAM
echo ����VRAM���[�h�ŋN����...
start http://127.0.0.1:8188
"%PYTHON_EXE%" main.py --novram
goto END

:CPU
echo CPU���[�h�ŋN����(���ɒx���ł�)...
start http://127.0.0.1:8188
"%PYTHON_EXE%" main.py --cpu
goto END

:PORT
echo.
set /p CUSTOM_PORT="�|�[�g�ԍ������ (��: 8080): "
echo �|�[�g %CUSTOM_PORT% �ŋN����...
start http://127.0.0.1:%CUSTOM_PORT%
"%PYTHON_EXE%" main.py --port %CUSTOM_PORT%
goto END

:END
pause
