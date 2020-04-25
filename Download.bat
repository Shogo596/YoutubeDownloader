@echo off

rem ===============================================================================================================================
rem �yYoutube�_�E�����[�_�[�z
rem �����Ɏw�肵��Youtube��URL����ō��掿�A�ō������œ�����_�E�����[�h����B
rem �_�E�����[�h��͐ݒ�t�@�C���i.ini�j�ɋL�q����B
rem (2020/04/25 �ǋL)�j�R�j�R����̃_�E�����[�h�ɂ��Ή������B�掿�̓x�X�g�G�t�H�[�g�B
rem 
rem 
rem ���g�p�c�[��
rem �Eyoutube-dl	:	Youtube���瓮����_�E�����[�h����B���Ȃ݂ɑ��̓���T�C�g������_�E�����[�h�ł���݂������������؁B
rem �Effmpeg		:	�_�E�����[�h��������̃t�H�[�}�b�g���s���B
rem 
rem 
rem ���p�����[�^����
rem �E%1�i�K�{�j	: �_�E�����[�h����Youtube��URL
rem �E%2�i�C�Ӂj	: �_�E�����[�h��̃f�B���N�g��
rem 
rem 
rem ���ݒ�t�@�C������
rem �EDL_DIR_PATH			�F	�_�E�����[�h��̃t�H���_�p�X
rem �ECONSOLE_INPUT_FLG		�F	�������w�肳��Ă��Ȃ��ꍇ�ɂ��̈������R���\�[�����͂����邩�ǂ����B
rem �EPAUSE_FLAG			�F	�����̍Ō��pause�����s���邩�ǂ����B�e�o�b�`����Ă΂�邱�Ƃ������False�ɂ���B
rem 
rem ===============================================================================================================================

echo.
echo ���������J�n����
echo.

rem ----------------------------------------------------------------------------------------
rem �J�����g�f�B���N�g���ړ�
rem ----------------------------------------------------------------------------------------
cd /d %~dp0

rem -------------------------------------------------------------------------------------------------------------------------------
rem �����l�ݒ�
rem -------------------------------------------------------------------------------------------------------------------------------
set DOWNLOADER_PATH=bin\youtube-dl.exe
set GET_INI_BATCH_PATH=..\Utils\Batch\GetIni.bat
set INI_FILE_PATH=config.ini

rem -------------------------------------------------------------------------------------------------------------------------------
rem INI�t�@�C���ݒ�擾
rem -------------------------------------------------------------------------------------------------------------------------------
call %GET_INI_BATCH_PATH% :READ_INI_VAL "CONFIG" "DL_DIR_PATH" DL_DIR_PATH %INI_FILE_PATH%
call %GET_INI_BATCH_PATH% :READ_INI_VAL "CONFIG" "CONSOLE_INPUT_FLG" CONSOLE_INPUT_FLG %INI_FILE_PATH%
call %GET_INI_BATCH_PATH% :READ_INI_VAL "CONFIG" "PAUSE_FLAG" PAUSE_FLAG %INI_FILE_PATH%

rem ----------------------------------------------------------------------------------------
rem �p�����[�^�̎擾
rem ----------------------------------------------------------------------------------------

rem ����1�����݂��Ă���΃_�E�����[�h��URL�Ƃ��Ď擾�B�Ȃꂯ�ΏI�� or �R���\�[��������͂�����B
if not "%~1"=="" (
	set URL="%~1"
) else (
	if %CONSOLE_INPUT_FLG%==True (
		echo �_�E�����[�h����URL���w�肵�Ă��������B
		set /p URL=">>> "
		echo.
	) else (
		echo ���s�����Ƀ_�E�����[�h����URL���w�肵�Ă��������B
		echo.
		exit /b
	)
)
rem URL�̑O��Ɂu"�v������B
set URL=%URL:"=%
rem set URL="%URL%"

rem ����2�����݂��Ă���΃_�E�����[�h��f�B���N�g���Ƃ��Ď擾�B
if not "%~2"=="" (
	set DL_DIR_PATH=%~2
)

rem ----------------------------------------------------------------------------------------
rem �_�E�����[�h�̎��s
rem ----------------------------------------------------------------------------------------
echo �ȉ��Ƀ_�E�����[�h���܂��B
echo %DL_DIR_PATH%
echo.

rem URL�Ƀj�R�j�R����̃A�h���X���܂܂�邩�𔻒�B���ʂɂ����DL�R�}���h�𕪊򂷂�B
echo "%URL%" | find "www.nicovideo.jp" > NUL
if %ERRORLEVEL%==0 goto :niconico

rem �f�t�H���g�iyoutube�j�̃_�E�����[�h�͈ȉ��̃R�}���h�Ŏ��{�B
:youtube
	bin\youtube-dl "%URL%" -f bestvideo[ext=mp4]+bestaudio[ext=m4a] --merge-output-format mp4 -o "%DL_DIR_PATH%\%%(title)s.%%(ext)s"
	goto :exit

rem �j�R�j�R����̏ꍇ�͈ȉ��̃R�}���h�Ŏ��{�B
rem DL�r���Œ��f����₷���̂ŌJ��Ԃ����s����悤�ɂ���B
:niconico
	bin\youtube-dl "%URL%" -f best -o "%DL_DIR_PATH%\%%(title)s.%%(ext)s"
	if not %ERRORLEVEL%==0 (
		echo.
		echo Retrying...
		echo.
		goto :niconico
	)
	goto :exit

rem ----------------------------------------------------------------------------------------
rem �I������
rem ----------------------------------------------------------------------------------------
:exit
echo.
echo ���������I������
if %PAUSE_FLAG%==True pause
exit /b
