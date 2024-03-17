@echo off
setlocal

::
::このバッチファイルは日本語で作成されているのでsjisで保存してね
::This batch file is created in Japanese, so please save it with sjis.
::

cd /d %~dp0

::日付の取得
set year=%date:~0,4%
set month=%date:~5,2%
set day=%date:~8,2%


::時刻の取得
set time2=%time: =0%

set hour=%time2:~0,2%
set minute=%time2:~3,2%
set second=%time2:~6,2%


::◆日時フォーマット整形して取得
set yyyymmdd-hhmmss=%year%%month%%day%-%hour%%minute%%second%

::◆バックアップ先のフォルダ名
set backupFolderName=_backup

::◆7zipのexeの場所
set sevenZipExePath="D:\Program Files\7-Zip\7z.exe"


::◆バックアップ対象のフォルダパス
set backupFromFolder=%~dp0

::◆バッチファイルのあるフォルダ名を取得する
for %%a in ("%CD%") do (set thisDirectory=%%~na) 


::◆バックアップ先のzipファイルのパス
set zipFilePath=%~dp0%backupFolderName%\%yyyymmdd-hhmmss%_%thisDirectory%.zip

::◆ログファイルのファイルパス
set logFilePath=%~dp0\backuplog.log


echo.
echo ----
echo 現在時刻: %yyyymmdd-hhmmss%
echo バックアップフォルダ名: %thisDirectory%
echo.
echo バックアップ対象のフォルダパス: %backupFromFolder%
echo バックアップ先のzipファイルパス: %zipFilePath%
echo バックアップ除外フォルダ : %backupFolderName%
echo ログファイルファイルパス : %logFilePath%
echo ----
echo.



::ログファイルの初期化
::ログ開始時刻の書き込み
echo.
echo %date% %time% >%logFilePath%
echo.

::7-Zipコマンドラインメモ
:: a : Add 圧縮
:: -zr : フォルダを除外
:: -mx=5：圧縮率（0無圧縮 9最大圧縮）
:: -mmt=on ：マルチスレッド化
:: -ssw：他のアプリが使用中のファイルも圧縮
:: -bb3 : ログの表示



::7-Zipでバックアップ実行
call %sevenZipExePath% a "%zipFilePath%" "%backupFromFolder%" -xr!"%backupFolderName%" -mmt=on -ssw -bb3 >>"%logFilePath%"


::ログファイル終了時刻の書き込み
echo.
echo %date% %time% >>%logFilePath%
echo.




