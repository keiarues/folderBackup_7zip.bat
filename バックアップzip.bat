@echo off
setlocal

::
::���̃o�b�`�t�@�C���͓��{��ō쐬����Ă���̂�sjis�ŕۑ����Ă�
::This batch file is created in Japanese, so please save it with sjis.
::

cd /d %~dp0

::���t�̎擾
set year=%date:~0,4%
set month=%date:~5,2%
set day=%date:~8,2%


::�����̎擾
set time2=%time: =0%

set hour=%time2:~0,2%
set minute=%time2:~3,2%
set second=%time2:~6,2%


::�������t�H�[�}�b�g���`���Ď擾
set yyyymmdd-hhmmss=%year%%month%%day%-%hour%%minute%%second%

::���o�b�N�A�b�v��̃t�H���_��
set backupFolderName=_backup

::��7zip��exe�̏ꏊ
set sevenZipExePath="D:\Program Files\7-Zip\7z.exe"


::���o�b�N�A�b�v�Ώۂ̃t�H���_�p�X
set backupFromFolder=%~dp0

::���o�b�`�t�@�C���̂���t�H���_�����擾����
for %%a in ("%CD%") do (set thisDirectory=%%~na) 


::���o�b�N�A�b�v���zip�t�@�C���̃p�X
set zipFilePath=%~dp0%backupFolderName%\%yyyymmdd-hhmmss%_%thisDirectory%.zip

::�����O�t�@�C���̃t�@�C���p�X
set logFilePath=%~dp0\backuplog.log


echo.
echo ----
echo ���ݎ���: %yyyymmdd-hhmmss%
echo �o�b�N�A�b�v�t�H���_��: %thisDirectory%
echo.
echo �o�b�N�A�b�v�Ώۂ̃t�H���_�p�X: %backupFromFolder%
echo �o�b�N�A�b�v���zip�t�@�C���p�X: %zipFilePath%
echo �o�b�N�A�b�v���O�t�H���_ : %backupFolderName%
echo ���O�t�@�C���t�@�C���p�X : %logFilePath%
echo ----
echo.



::���O�t�@�C���̏�����
::���O�J�n�����̏�������
echo.
echo %date% %time% >%logFilePath%
echo.

::7-Zip�R�}���h���C������
:: a : Add ���k
:: -zr : �t�H���_�����O
:: -mx=5�F���k���i0�����k 9�ő刳�k�j
:: -mmt=on �F�}���`�X���b�h��
:: -ssw�F���̃A�v�����g�p���̃t�@�C�������k
:: -bb3 : ���O�̕\��



::7-Zip�Ńo�b�N�A�b�v���s
call %sevenZipExePath% a "%zipFilePath%" "%backupFromFolder%" -xr!"%backupFolderName%" -mmt=on -ssw -bb3 >>"%logFilePath%"


::���O�t�@�C���I�������̏�������
echo.
echo %date% %time% >>%logFilePath%
echo.




