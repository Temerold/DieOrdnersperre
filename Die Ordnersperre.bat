@echo off
setlocal enabledelayedexpansion
chcp 65001
title Die Ordnersperre
cls

:: Konstanten
set "folder=Ordner"
set "lang_file=%folder%\lang"
set "pass_file=%folder%\pass"

:: Installation
if not exist %folder%\ mkdir %folder%
if not exist %lang_file% >%lang_file% echo d
<%lang_file% set /p "glob_lang="
if not "%glob_lang%" == "d" if not "%glob_lang%" == "e" if not "%glob_lang%" == "s" (
	>%lang_file% echo d
	set "glob_lang=d"
	ECHO Sprachdatei nicht gefunden.
	ECHO Wechseln Sie in die Standardsprache: Deutsch
)
call :i18n_init
if not exist %pass_file% (
	set /p "creat_pass=!passwort_erstellen[%glob_lang%]!: "
	>%pass_file% echo !creat_pass!
)

:: Passworteingabe
cls
<%pass_file% set /p "pass="
set /p "insert=!password[%glob_lang%]!: "
if "%insert%" == "%pass%" goto menu
goto fail

:menu
cls
echo 1. !sperren[%glob_lang%]!
echo 2. !freischalten[%glob_lang%]!
echo 3. !passwort_andert[%glob_lang%]!
echo 4. !sprache_wechseln[%glob_lang%]!
echo 5. !schalte_aus[%glob_lang%]!
choice /c:12345 /n

cls

if "%errorlevel%" == "1" (
	attrib +h +s %folder%
	echo !ordner_gesperrt[%glob_lang%]!
)
if "%errorlevel%" == "2" (
	attrib -h -s %folder%
	echo !ordner_entsperrt[%glob_lang%]!
)
if "%errorlevel%" == "3" (
	set /p "new_pass=!neues_passwort[%glob_lang%]!: "
	>%pass_file% echo !new_pass!
)
if "%errorlevel%" == "4" goto :lang
if "%errorlevel%" == "5" exit /b

echo !drucken_taste[%glob_lang%]!
pause >nul
goto :menu

:lang
cls
echo !wahle_sprache[%glob_lang%]!
echo 1. !deutsche[%glob_lang%]!
echo 2. !englisch[%glob_lang%]!
echo 3. !schwedisch[%glob_lang%]!
echo.
echo 4. !kehren_menu[%glob_lang%]!
choice /C:1234 /N >nul
if "%errorlevel%" == "1" set "glob_lang=d"
if "%errorlevel%" == "2" set "glob_lang=e"
if "%errorlevel%" == "3" set "glob_lang=s"
if "%errorlevel%" == "4" goto :menu
>%lang_file% echo %glob_lang%
cls
echo !umgestellt[%glob_lang%]!
echo !drucken_taste[%glob_lang%]!
pause >nul
goto :menu

:fail
cls
echo !fail[1][%glob_lang%]!
echo !fail[2][%glob_lang%]!
echo !fail[3][%glob_lang%]!
pause >nul
exit /b

:i18n_init
:: Anmeldeoptionen
set "passwort_erstellen[d]=Passwort erstellen"
set "passwort_erstellen[e]=Create a password"
set "passwort_erstellen[s]=Skapa ett l??senord"
set "passwort]=Passwort"
set "passworte]=Password"
set "passworts]=L??senord"

:: Men??optionen
set "sperren[d]=Sperren"
set "sperren[e]=Lock"
set "sperren[s]=L??s"
set "freischalten[d]=Freischalten"
set "freischalten[e]=Unlock"
set "freischalten[s]=L??s upp"
set "passwort_andert[d]=Passwort ??ndern"
set "passwort_andert[e]=Reset password"
set "passwort_andert[s]=??ndra l??senord"
set "sprache_wechseln[d]=Sprache wechseln"
set "sprache_wechseln[e]=Change language"
set "sprache_wechseln[s]=??ndra spr??k"
set "schalte_aus[d]=Schalte aus"
set "schalte_aus[e]=Close window"
set "schalte_aus[s]=St??ng av"

:: Men??aktionsoptionen
set "ordner_gesperrt[d]=Der Ordner ist gesperrt."
set "ordner_gesperrt[e]=Folder locked."
set "ordner_gesperrt[s]=L??ste mappen."
set "ordner_entsperrt[d]=Der Ordner ist entsperrt."
set "ordner_entsperrt[e]=Folder unlocked."
set "ordner_entsperrt[s]=L??ste upp mappen."
set "neues_passwort[d]=Neues Passwort"
set "neues_passwort[e]=New password"
set "neues_passwort[s]=Nya l??senord"
set "passwort_geandert[d]=Passwort ge??ndert."
set "passwort_geandert[e]=Password changed."
set "passwort_geandert[s]=L??senordet ??ndrat."
set "drucken_taste[d]=Dr??cken Sie eine beliebige Taste, um zum Men?? zur??ckzukehren."
set "drucken_taste[e]=Press any key to return to the menu."
set "drucken_taste[s]=Tryck p?? valfri knapp f??r att ??terg?? till menyn."

:: Sprachauswahloptionen
set "wahle_sprache[d]=W??hle deine Sprache"
set "wahle_sprache[e]=Choose your language"
set "wahle_sprache[s]=V??lj ditt spr??k"
set "deutsche[d]=Deutsche"
set "deutsche[e]=German"
set "deutsche[s]=Tyska"
set "englisch[d]=Englisch"
set "englisch[e]=English"
set "englisch[s]=Engelska"
set "schwedisch[d]=Schwedisch"
set "schwedisch[e]=Swedish"
set "schwedisch[s]=Svenska"
set "kehren_menu[d]=Kehren Sie zum Men zur??ck"
set "kehren_menu[e]=Return to the menu"
set "kehren_menu[s]=??terg?? till menyn"
set "umgestellt[d]=Auf Deutsch umgestellt."
set "umgestellt[e]=Changed language to English."
set "umgestellt[s]=Bytte spr??k till svenska."

:: Optionen f??r Kennwortfehler
set "fail[1][d]=Falsches Passwort."
set "fail[1][e]=Incorrect password."
set "fail[1][s]=Fel l??senord."
set "fail[2][d]=Schlie??t das Programm."
set "fail[2][e]=Close the program."
set "fail[2][s]=St??nger programmet."
set "fail[3][d]=Drcken Sie eine beliebige Taste, um das Programm zu schlie??en."
set "fail[3][e]=Press any key to close the program."
set "fail[3][s]=Tryck p?? valfri knapp f??r att st??nga programmet."
