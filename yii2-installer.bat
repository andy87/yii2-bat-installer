@echo off
setlocal

chcp 65001

IF NOT EXIST composer.phar (

	echo ### Загрузка Composer...

	php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"

	php -r "if (hash_file('sha384', 'composer-setup.php') === '55ce33d7678c5a611085589f1f3ddf8b3c52d662cd01d4ba75c0ee0459970c2200a51f492d557530c71c15d8dba01eae') { echo 'Installer verified'; } else { echo 'Installer corrupt'; unlink('composer-setup.php'); } echo PHP_EOL;"

	php composer-setup.php

	php -r "unlink('composer-setup.php');"

) ELSE (

	echo ### `composer.phar` уже установлен...
)

IF NOT EXIST yii (

	echo ### Установка Yii2 advanced...

	php composer.phar create-project --prefer-dist yiisoft/yii2-app-advanced yii

) ELSE (

	echo ### `create-projec` уже был выполнен...
)

IF NOT EXIST "%~dp0/yii/common/config/main-local.php" (

	echo ### Выполнение команды init...

  	cd yii && php init --env=Development --overwrite=All
  	
) ELSE (

	echo ### `init` уже был выполнен...
)

echo Повелитель! Укажите имя проекта:
set /p project_name=

echo Хозяин! Укажите имя базы данных:
set /p db_name=

echo ### Обновляем файл конфигурации common\config\main-local ...

set "file=%~dp0yii\common\config\main-local.php"
powershell -Command "(gc '%file%') -replace 'yii2advanced', '%db_name%' | Out-File '%file%'"

echo ### Обновляем файл конфигурации backend\config\main ...

set "file=%~dp0yii\backend\config\main.php"
set "replace=app-%project_name%-backend"
powershell -Command "(gc '%file%') -replace 'app-backend', '%replace%' | Out-File '%file%'"

set "replace=app-%project_name%-backend-csrf"
powershell -Command "(gc '%file%') -replace '_csrf-backend', '%replace%' | Out-File '%file%'"

set "replace=app-%project_name%-backend-session"
powershell -Command "(gc '%file%') -replace 'advanced-backend', '%replace%' | Out-File '%file%'"

echo ### Обновляем файл конфигурации frontend\config\main ...
	
set "file=%~dp0yii\frontend\config\main.php"
set "replace=app-%project_name%-frontend"
powershell -Command "(gc '%file%') -replace 'app-frontend', '%replace%' | Out-File '%file%'"

set "replace=app-%project_name%-frontend-csrf"
powershell -Command "(gc '%file%') -replace '_csrf-frontend', '%replace%' | Out-File '%file%'"

set "replace=app-%project_name%-frontend-session"
powershell -Command "(gc '%file%') -replace 'advanced-frontend', '%replace%' | Out-File '%file%'"

echo Готово.

pause	
