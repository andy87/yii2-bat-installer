# yii2-bat-installer

Файл предназначен для первой(чистой) установки проекта `yii-advanced`.

Последовательность выполнения команд: 
 - скачает `composer.phar` в директорию откуда был запуск батника
 - установит `yii-advanced` в папку `yii`
 - выполнит `init` в режиме `developer`
 - пропишет имя для базы данных в `common/config/main-local.php`
 - пропишет ID проекта в некоторые параметры конфига `backend` & `frontend`:
   * id
   * csrfParam
   * identityCookie['name']
   * session['name']

Зависимости:
 * php в PATH
 * установленный composer 
