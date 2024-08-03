@echo off
setlocal enabledelayedexpansion

:: Adjust console window size
mode con: cols=60 lines=15
title Pomodoro Timer

:: Default values
set "default_work_time=25"
set "default_short_break_time=5"
set "default_long_break_time=10"
set "default_sound_file=C:\Windows\Media\Alarm01.wav"

:: Load settings from file if exists
if exist settings.txt (
    set /p work_time=<settings.txt
    set /p short_break_time=<settings.txt
    set /p long_break_time=<settings.txt
    set /p sound_file=<settings.txt
) else (
    set work_time=%default_work_time%
    set short_break_time=%default_short_break_time%
    set long_break_time=%default_long_break_time%
    set sound_file=%default_sound_file%
)

:: Convert minutes to seconds
set /a work_time=work_time*60
set /a short_break_time=short_break_time*60
set /a long_break_time=long_break_time*60

:: Path to nircmd executable
set "nircmd_path=bin\nircmd\nircmd.exe"

:: User information
set "username=%USERNAME%"

:: Main menu loop
:menu
cls
echo ============================================================
echo                      Pomodoro Timer
echo ============================================================
echo [1] Start Pomodoro Timer
echo [2] View Report
echo [3] Change Settings
echo [4] Show Version
echo [5] Exit
echo ============================================================
set /p choice=Choose an option: 

if "%choice%"=="1" goto start_timer
if "%choice%"=="2" goto view_report
if "%choice%"=="3" goto change_settings
if "%choice%"=="4" goto show_version
if "%choice%"=="5" exit /b

goto menu

:start_timer
:: Initialize totals
set cycle=0
set total_work_time=0
set total_short_break_time=0
set total_long_break_time=0

:: Create or clear the report file
echo Pomodoro report for %username% > report.txt
echo ========================= >> report.txt

:loop
cls
echo ============================================================
echo                     Pomodoro Timer - Work
echo ============================================================
call :countdown %work_time% "Work"
set /a total_work_time+=%work_time%
call :update_report
powershell -c Start-Process powershell -ArgumentList "(New-Object Media.SoundPlayer '%sound_file%').PlaySync();" -NoNewWindow -WindowStyle Hidden

msg * Time to take a short break!
call :countdown %short_break_time% "Short Break"
set /a total_short_break_time+=%short_break_time%
call :update_report

set /a cycle+=1
if %cycle%==4 (
    cls
    echo ============================================================
    echo                Pomodoro Timer - Long Break
    echo ============================================================
    msg * Time to take a long break!
    call :countdown %long_break_time% "Long Break"
    powershell -c Start-Process powershell -ArgumentList "(New-Object Media.SoundPlayer '%sound_file%').PlaySync();" -NoNewWindow -WindowStyle Hidden

    set /a total_long_break_time+=%long_break_time%
    call :update_report
    set cycle=0
)

if %cycle% lss 4 (
    powershell -c Start-Process powershell -ArgumentList "(New-Object Media.SoundPlayer '%sound_file%').PlaySync();" -NoNewWindow -WindowStyle Hidden
    msg * Short break is over, back to work!
) else (
    powershell -c Start-Process powershell -ArgumentList "(New-Object Media.SoundPlayer '%sound_file%').PlaySync();" -NoNewWindow -WindowStyle Hidden
    msg * Long break is over, back to work!
)

goto loop

:countdown
set /a seconds=%1
set label=%2
:countdown_loop
set /a minutes=seconds/60
set /a remaining_seconds=seconds%%60
if !remaining_seconds! lss 10 set remaining_seconds=0!remaining_seconds!

:: Bring window to front if less than or equal to 10 seconds remaining
if !seconds! leq 10 (
    "%nircmd_path%" win activate ititle "Pomodoro Timer"
)

cls
echo ============================================================
echo                     Pomodoro Timer - !label!
echo ============================================================
if !seconds! leq 10 (
    color 4f
) else (
    color 2f
)
echo                     Time remaining: !minutes!:!remaining_seconds!
timeout /t 1 /nobreak >nul 2>&1
set /a seconds-=1
if !seconds! geq 0 goto countdown_loop
exit /b

:update_report
cls
echo Report for %username%
echo =========================
echo Date: %date%  - Time: %time%
echo =========================
echo Time Work: %total_work_time% seconds
echo Time Short Break: %total_short_break_time% seconds
echo Time Long Break: %total_long_break_time% seconds
echo =========================
echo. >> report.txt
echo Date: %date%  - Time: %time% >> report.txt
echo Time Work: %total_work_time% seconds >> report.txt
echo Time Short Break: %total_short_break_time% seconds >> report.txt
echo Time Long Break: %total_long_break_time% seconds >> report.txt
exit /b

:view_report
cls
echo ============================================================
echo                      View Report
echo ============================================================
if not exist report.txt (
    echo No report found. Please run the timer to generate a report.
    pause
    goto menu
)

:: Display the content of the report
type report.txt

pause
goto menu

:change_settings
cls
echo ============================================================
echo                      Change Settings
echo ============================================================
set /p work_time=Enter work duration in minutes (default 25): 
set /p short_break_time=Enter short break duration in minutes (default 5): 
set /p long_break_time=Enter long break duration in minutes (default 15): 

:: Use default values if input is empty
if "%work_time%"=="" set work_time=%default_work_time%
if "%short_break_time%"=="" set short_break_time=%default_short_break_time%
if "%long_break_time%"=="" set long_break_time=%default_long_break_time%

:: Validate input
for %%i in (%work_time% %short_break_time% %long_break_time%) do (
    if %%i leq 0 (
        echo Invalid input detected. Please enter positive values.
        pause
        goto menu
    )
)

:: Sound settings
echo ============================================================
echo                      Select Sound
echo ============================================================
echo [1] Default Alarm Sound
echo [2] Custom Sound
echo [3] No Sound
echo ============================================================
set /p sound_choice=Choose an option: 

if "%sound_choice%"=="1" set sound_file=%default_sound_file%
if "%sound_choice%"=="2" (
    set /p sound_file=Enter the path to your custom sound file:
)
if "%sound_choice%"=="3" set sound_file=""

:: Save settings to file
(
echo %work_time%
echo %short_break_time%
echo %long_break_time%
echo %sound_file%
) > settings.txt

:: Update time values
set /a work_time=work_time*60
set /a short_break_time=short_break_time*60
set /a long_break_time=long_break_time*60

echo Settings updated successfully!
pause
goto menu

:show_version
cls
echo ============================================================
echo                 Pomodoro Timer by NMINHDUCIT
echo ============================================================
echo Version: 0.1
echo GitHub/Twitter/Telegram: @nminhducit
echo Email: nminhducit@gmail.com
echo ============================================================
pause
exit /b
