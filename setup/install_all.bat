@echo off

REM �X�N���v�g�̃f�B���N�g���Ɉړ�
cd /d "%~dp0"

cls
echo ================================================
echo ComfyUI + SVD �����N���b�N�C���X�g�[���[
echo ================================================
echo.
echo ���̃X�N���v�g�͈ȉ����������s���܂�:
echo 1. ComfyUI�̃C���X�g�[��
echo 2. SVD�J�X�^���m�[�h�̃C���X�g�[��
echo 3. SVD���f���̃_�E�����[�h
echo 4. �N���X�N���v�g�̍쐬
echo.
echo ���v����: ��20-30��(�l�b�g���x�ɂ��)
echo �K�v�e��: ��15GB
echo.
set /p START="�J�n���܂���? (Y/N): "
if /i not "%START%"=="Y" exit /b

REM �X�e�b�v1: ��{�Z�b�g�A�b�v
call setup_comfyui_svd.bat
if %errorLevel% neq 0 (
    echo [�G���[] �Z�b�g�A�b�v�Ɏ��s���܂���
    pause
    exit /b 1
)

REM �X�e�b�v2: ���f���_�E�����[�h
call "%~dp0download_svd_model.bat" AUTO
if %errorLevel% neq 0 (
    echo [�G���[] ���f���̃_�E�����[�h�Ɏ��s���܂���
    pause
    exit /b 1
)

echo.
echo ================================================
echo �C���X�g�[������!
echo ================================================
echo.
echo ������ComfyUI���N�����܂���?
set /p LAUNCH="�N������ (Y/N): "
if /i "%LAUNCH%"=="Y" (
    call "%~dp0..\daily-use\run_comfyui.bat"
)
