Open Server Panel 6 <sup>(Beta)</sup>
=======================================
Представляем вашему вниманию программный комплекс для платформы Windows включающий в себя тщательно подобранный набор серверного программного обеспечения, а так же удобную и продуманную панель управления с мощными возможностями по администрированию и настройке всех её компонентов.

Open Server Panel широко используется с целью разработки, отладки и тестирования веб-проектов, а так же для предоставления веб-сервисов в локальных сетях. Проект завоевал огромную популярность у начинающих веб-разработчиков, т.к. позволяет быстро развернуть рабочую среду и сразу начать изучение веб-технологий без сложных манипуляций по установке и настройке большого количества незнакомого ПО.

| ПРЕДУПРЕЖДЕНИЕ: Дистрибутив загружен не полностью! Это предупреждение исчезнет, когда мы завершим публикацию Beta версии. |
| --- |

Управление (CLI)
------------
На данный момент управление программой доступно только в консольном режиме. Веб-интерфейс находится в процессе разработки и станет доступен в ближайшем будущем.
```
Использование: osp <команда> [<аргументы>]

Опции командной строки:

add            <module> [append] Объединить среду окружения модуля с текущей средой окружения консоли
                                 С флагом [append] при слиянии сред окружения переменная PATH модуля
                                 (если задана) добавляется в конец текущего значения PATH в консоли
                                 Внимание! Создание общей среды окружения для нескольких модулей из
                                 одной группы может привести к непредсказуемым ошибкам в их работе!
                                 Внимание! Объединение среды окружения модуля(ей) со средой окружения
                                 Windows может привести к конфликтам с аналогичными модулями в системе!
exit                             Завершить работу программы
help                             Показать эту информацию об использовании
info                             Показать информацию о текущей среде окружения
log            <module|main> [n] Показать журнал модуля/программы (последние n строк, по умолчанию: 10)
list                             Показать информацию о модулях
on|off|restart <module> [fast]   Включить/выключить/перезапустить модуль
                                 Используйте [fast] для (пере)запуска модуля без пересоздания конфигов
reset                            Сбросить текущую среду окружения (оригинальная среда Windows)
set            <module|default>  Применить среду окружения модуля (default: базовая среда программы)
shell          <module>          Запустить shell/cli оболочку модуля (если доступно)
status         <module>          Показать информацию о статусе модуля
sysprep        [silent|ssd]      Запустить инструмент подготовки операционной системы
                                 Используйте [silent] для запуска подготовки системы в тихом режиме
                                 Используйте [ssd] для запуска в тихом режиме с оптимизацией под SSD
                                 Подготовка в тихом режиме происходит автоматически и без отслеживания
                                 прогресса, после окончания процедуры будет выполнена перезагрузка!
                                 Для запуска процесса тихой подготовки без запроса подтверждения со
                                 стороны Windows команда должна быть запущена от имени Администратора
version                          Показать информацию о версии программы

Примеры использования:

osp set PostgreSQL-9.6           Применение в консоли среды окружения модуля PostgreSQL-9.6
osp restart mysql-8.0            Перезапуск модуля MySQL-8.0 (имя модуля принимается в любом регистре)
osp log main 20                  Вывод в консоль 20-ти последних строк из журнала программы
osp reset & osp add mongodb-5.0  Объединение среды окружения MongoDB-5.0 со средой окружения Windows
```
Настройки программы
------------
Настройки программы и модулей (глобальные опции) задаются в файле `config/program.ini`.

:warning: **Важно**: Для применения изменений необходимо перезапустить программу.

### Секция `[main]` ###
Секция содержит основные настройки программы.
| Параметр | Описание |
| :---: | :--- |
| `allowed_env_vars` | Список переменных среды окружения Windows (через пробел) передаваемых всем запускаемым процессам. Белый список переменных необходим для фильтрации рабочей среды окружения модулей от среды установленного в систему аналогичного ПО.<br><br>Вносите изменения в этот список только в том случае, если вы точно знаете что делаете, т.к. это может нарушить нормальную работу модулей. |
| `clear_dns_cache` | Очищать системный кеш DNS при изменении файла HOSTS (`on`/`off`). Отключайте эту опцию только в том случае, если вы вручную внесли изменения в файл HOST, очистили кеш DNS и больше не планируете вносить изменения в настройки программы и модулей. Так же эту опцию можно отключить если вы используете единственный домен - localhost. |
| `hosts_file` | Использовать файл HOSTS (`on`/`off`). Если выключено, то следующие возможности станут недоступны: использование имён модулей в качестве доменов (подключение будет возможным только по IP), использование локальных доменов (только localhost), включая использование локального домена для доступа к панели управления (см. `web_panel_domain`). |
| `hosts_file_encoding` | Кодировка файла HOSTS. Допустимые значения кодировки: `UTF8`, `ANSI`, `ASCII`. |
| `lang` | Язык программы. Допустимые значения языка: (см. содержимое `./langs`). |
| `virtual_drive` | Использовать виртуальный диск (`on`/`off`). Виртуальный диск позволяет избежать проблем с некорректной работой модулей при наличии в пути у рабочего каталога пробелов или символов национального (не английского) алфавита.<br><br>Разрешённые символы в пути до корневого каталога с программой, которые допускают возможность работы без виртуального диска (через запятую):<br>`A-Z,a-z,0-9,.,$,+,-,(,),[,],{,},\,:,_,&,!`<br><br>При наличии в пути пробелов и других недопустимых символов использование программы без виртуального диска будет невозможным. |
| `virtual_drive_letter` | Буква виртуального диска. Выбранная буква должна быть свободной, т.е. диск с такой буквой не должен присутствовать в системе.<br>Допустимые значения для буквы диска (только латиница): `A-Z`. |
| `web_panel` | Веб-интерфейс управления программой (`on`/`off`). Если веб-интерфейс выключен, то управление программой доступно только посредством командной строки. |
| `web_panel_domain` | Локальный домен панели управления. Если включено использование файла HOSTS, то панель управления будет доступна в браузере на указанном домене.<br>Если в браузере используется VPN/прокси, то в настройках VPN/прокси необходимо задать исключение для этого домена. |
| `web_panel_ip` | IP адрес панели управления. Запуск программы будет невозможен в случае указания неверного IP, либо если 80-й или 443-й порт на этом IP уже используется.<br>Если в браузере используется VPN/прокси, то в настройках VPN/прокси необходимо задать исключение для этого IP. |

### Секция `[modules]` ###
Секция содержит глобальные настройки модулей. Они используются в том случае, если в настройках модуля указано значение auto (по умолчанию). Эти значения можно переопределить в файле настроек у любого модуля с возможностью включения/выключения, а значения опций `terminal_codepage` и `time_zone` можно переопределить в настройках любых модулей. См. файл `./config/<имя_модуля>/<имя_профиля>/settings.ini`.
| Параметр | Описание |
| :---: | :--- |
| `control_timeout` | Пауза между выполнением команд (включение, выключение и перезапуск модуля). Обязательная пауза крайне необходима для того, чтобы любой модуль мог корректно выполнить инициализацию/закрытие своих файлов/логов/баз данных и т.д..<br><br>Если новая команда подана сразу после предыдущей, например через 2 секунды при значении опции `5s`, то она будет задержана на оставшиеся 3 сек., в противом случае команда будет выполнена мгновенно. Значение должно быть равным `5` или более сек. (меньшее значение не будет использовано программой).<br><br>Допустимо использование следующих обозначений: `s` - секунды (не обязательно). |
| `log_max_filesize` | Максимальный размер журнала (`0` - отключает ограничение). Если размер какого-либо журнала превысит указанный, то при очередном запуске модуля его файл журнала будет пересоздан.<br><br>Допустимо использование следующих обозначений: `B` - байты, `K` - килобайты, `M` - мегабайты, `G` - гигабайты, `T` - терабайты. Для принудительной очистки логов при каждом запуске установите значение равным `1` (к цифрам без обозначений применяются `B` - байты). |
| `log_write_title` | Добавлять заголовок в лог модуля при каждом запуске (`on`/`off`). Полезно для визуального разграничения рабочих сессий если не используется автоматическая очистка журнала модуля. |
| `max_probation_fails` | Максимальное кол-во событий неожиданного завершения работы в период испытательного срока после которых модуль перейдёт в состояние "Ошибка" (см. probation). |
| `max_shutdown_time` | Максимальное время выключения модуля (`0` - отключает ограничение). Если модуль не успел завершить свою работу за указанное время, то по завершению ожидания его процесс будет принудительно остановлен (терминирован).<br><br>Не следует устанавливать этот лимит если вы точно не знаете что делаете, т.к. преждевременная принудительная остановка рабочего процесса активного модуля может привести к различным проблемам (порча БД, неполная запись логов и др.).<br><br>Допустимо использование следующих обозначений: `s` - секунды, `m` - минуты, `h` - часы, `d` - дни. |
| `probation` | Испытательный срок с момента запуска необходимый для проверки работоспособности модуля. До конца испытательного срока автоматическое восстановление процесса неактивно (`0` - отключает эту проверку).<br><br>Если модуль проработал меньше указанного времени и его процесс неожиданно завершился, то он не будет автоматически перезапущен и перейдёт в состояние "Ошибка" ожидая дополнительных действий от пользователя (например исправления файлов конфигурации).<br><br>Не рекомендуется устанавливать значение 0 или задавать слишком короткий период проверки (менее 30 сек.).<br><br>Допустимо использование следующих обозначений: `s` - секунды, `m` - минуты, `h` - часы, `d` - дни. |
| `silent_mode` | Тихий режим работы (`on`/`off`). В этом режиме не отображаются сообщения об ошибках, которые генерирует служба Error reporting или сам модуль. Допускается временное выключение режима, когда требуется разобраться с проблемами в работе модуля, в остальное время он должен быть постоянно включён. |
| `terminal_codepage` | Кодировка консоли при работе со средой окружения модуля. Можно использовать значение `system`, в этом случае будет использоваться системная кодировка. |
| `time_zone` | Часовой пояс (временная зона). В качестве значения этого параметра необходимо указать часовой пояс в формате Etc/GMT (например: `Etc/GMT-3`). Можно использовать значение `system`, в этом случае будет использоваться системный часовой пояс.<br><br>Внимание! Формат Etc/GMT отличается от UTC обратным порядком, например: `Etc/GMT-3` = `UTC/GMT+3` = `UTC+03:00` = `Europe/Moscow`. |

### Секция `[environment]` ###
Секция служит для управления переменными общей среды окружения. Заданные здесь переменные применяются ко всем модулям, к запускаемым процессам и к окружению самой программы, но не влияют на переменные среды окружения Windows.<br><br>Для любого модуля эти переменные можно переопределить/дополнить/удалить в файле его настроек `./config/<имя_модуля>/<имя_профиля>/settings.ini`.<br><br>Для удаления переменной из среды окружения задайте пустое значение или используйте глобальный фильтр (см. `allowed_env_vars`).<br><br>Добавьте в конец `PATH` следующую запись если планируете использовать PowerShell: `;%SYSTEMROOT%\System32\WindowsPowerShell\v1.0\`

Доступны следующие шаблонные переменные:

| Переменная | Описание |
| :---: | :--- |
| `{root_dir}` | Корневой каталог программы (полный путь) |
| `{root_drive}` | Диск корневого каталога |
| `{root_path}` | Путь к корневому каталогу программы |
| `{time_zone}` | Часовой пояс в формате Etc/GMT (см. `time_zone`) |

Помимо шаблонных переменных вы можете использовать любые переменные среды окружения Windows, например: `%SYSTEMDRIVE%`, `%USERNAME%`, `%PATH%` и т.д.

Значения секции заданные "по умолчанию":
```
[environment]

PATH                  = {root_dir}\bin;%SYSTEMROOT%\system32;%SYSTEMROOT%;%SYSTEMROOT%\System32\Wbem
HOMEDRIVE             = {root_drive}
HOMEPATH              = {root_path}\home
TEMP                  = {root_dir}\temp
TMP                   = {root_dir}\temp
```

Настройки модулей
------------
Настройки модуля задаются в файле `./config/<имя_модуля>/<имя_профиля>/settings.ini`. По умолчанию используется профиль `Default`. Резервная копия настроек и конфигурации модуля хранится в каталоге `./modules/<имя_модуля>/original` и в будущем будет использоваться в панели управления для функции восстановления оригинальной конфигурации.<br><br>Вы можете создавать дополнительные профили настроек для модулей. Для создания нового профиля, например MyProfile, достаточно скопировать каталог `./config/<имя_модуля>/Default` в `./config/<имя_модуля>/MyProfile` и изменить в нём настройки модуля или шаблоны конфигурации по своему усмотрению. Имя рабочего профиля задаётся в файле `./config/<имя_модуля>/module.ini`.<br><br>:warning: **Важно**: Для применения любых изменений необходимо перезапустить модуль или саму программу (если модуль не имеет этой возможности).

### Секция `[main]` ###
Секция содержит основные настройки модуля, все параметры этой секции являются необязательными.

| Параметр | Описание |
| :---: | :--- |
| `ip` | IP-адрес модуля. Можно задавать несколько IP (через пробел) и IP в формате IPv6 в случаях когда модуль это поддерживает. Если вы указываете несколько IP-адресов, то при обновлении файла HOSTS в качестве IP для имени модуля будет использован первый указанный IP. Настройка IP игнорируется для модулей DNS. |
| `port` | Порт модуля. Настройка порта игнорируется для модулей DNS. |
| `cmd` | Команда запуска модуля. Можно использовать шаблонные переменные. |
| `cmd_dir` | Каталог запуска модуля (каталог должен существовать). Можно использовать шаблонные переменные. |
| `directories` | Каталоги необходимые для работы модуля (через пробел). Если каталог не существует он будет создан в процессе запуска модуля. Можно использовать шаблонные переменные. |
| `query_log_values` | Доступные уровни журналирования запросов (принимает разные значения и поддерживается не всеми модулями) |
| `query_log_level` | Уровень журналирования запросов |
| `log_level_values` | Доступные уровни журналирования (принимает разные значения и поддерживается не всеми модулями) |
| `log_level` | Уровень журналирования |
| `shell` | Команда запуска SHELL оболочки или CLI интерфейса модуля. Можно использовать шаблонные переменные. |
| `control_timeout` | Пауза между выполнением команд (включение, выключение и перезапуск модуля). Обязательная пауза крайне необходима для того, чтобы любой модуль мог корректно выполнить инициализацию/закрытие своих баз данных, логов и др.<br><br>Если новая команда подана сразу после предыдущей, например через 2 секунды при значении опции `5s`, то она будет задержана на оставшиеся 3 сек., в противом случае команда будет выполнена мгновенно. Значение должно быть равным `5` или более сек. (меньшее значение не будет использовано программой).<br><br>Можно использовать значение `auto`, в этом случае будет использовано глобальное значение из основных настроек программы.<br><br>Допустимо использование следующих обозначений: `s` - секунды (не обязательно). |
| `log_max_filesize` | Максимальный размер журнала (`0` - отключает ограничение). Если размер какого-либо журнала превысит указанный, то при очередном запуске модуля его файл журнала будет пересоздан.<br><br>Можно использовать значение `auto`, в этом случае будет использовано глобальное значение из основных настроек программы.<br><br>Допустимо использование следующих обозначений: `B` - байты, `K` - килобайты, `M` - мегабайты, `G` - гигабайты, `T` - терабайты. Для принудительной очистки логов при каждом запуске установите значение равным `1` (к цифрам без обозначений применяются `B` - байты). |
| `log_write_title` | Добавлять заголовок в лог модуля при каждом запуске (`on`/`off`). Полезно для визуального разграничения рабочих сессий если не используется автоматическая очистка журнала модуля.<br><br>Можно использовать значение `auto`, в этом случае будет использовано глобальное значение из основных настроек программы. |
| `max_probation_fails` | Максимальное кол-во событий неожиданного завершения работы в период испытательного срока после которых модуль перейдёт в состояние "Ошибка" (см. probation).<br><br>Можно использовать значение `auto`, в этом случае будет использовано глобальное значение из основных настроек программы. |
| `max_shutdown_time` | Максимальное время выключения модуля (`0` - отключает ограничение). Если модуль не успел завершить свою работу за указанное время, то по завершению ожидания его процесс будет принудительно остановлен (терминирован).<br><br>Не следует устанавливать этот лимит если вы точно не знаете что делаете, т.к. преждевременная принудительная остановка рабочего процесса активного модуля может привести к различным проблемам (порча БД, неполная запись логов и др.).<br><br>Можно использовать значение `auto`, в этом случае будет использовано глобальное значение из основных настроек программы.<br><br>Допустимо использование следующих обозначений: `s` - секунды, `m` - минуты, `h` - часы, `d` - дни. |
| `probation` | Испытательный срок с момента запуска необходимый для проверки работоспособности модуля. До конца испытательного срока автоматическое восстановление процесса неактивно (`0` - отключает эту проверку).<br><br>Если модуль проработал меньше указанного времени и его процесс неожиданно завершился, то он не будет автоматически перезапущен и перейдёт в состояние "Ошибка" ожидая дополнительных действий от пользователя (например исправления файлов конфигурации).<br><br>Не рекомендуется устанавливать значение 0 или задавать слишком короткий период проверки (менее 30 сек.).<br><br>Можно использовать значение `auto`, в этом случае будет использовано глобальное значение из основных настроек программы.<br><br>Допустимо использование следующих обозначений: `s` - секунды, `m` - минуты, `h` - часы, `d` - дни. |
| `silent_mode` | Тихий режим работы (`on`/`off`). В этом режиме не отображаются сообщения об ошибках, которые генерирует служба Error reporting или сам модуль. Допускается временное выключение режима, когда требуется разобраться с проблемами в работе модуля, в остальное время он должен быть постоянно включён.<br><br>Можно использовать значение `auto`, в этом случае будет использовано глобальное значение из основных настроек программы. |
| `terminal_codepage` | Кодировка консоли при работе со средой окружения модуля. Можно использовать специальные значения `system` (системная кодировка) или `auto` (глобальное значение из основных настроек программы). |
| `time_zone` | Часовой пояс (временная зона). В качестве значения этого параметра необходимо указать часовой пояс в формате Etc/GMT (например: `Etc/GMT-3`). Можно использовать специальные значения `system` (системный часовой пояс) или `auto` (глобальное значение из основных настроек программы).<br><br>Внимание! Формат Etc/GMT отличается от UTC обратным порядком, например: `Etc/GMT-3` = `UTC/GMT+3` = `UTC+03:00` = `Europe/Moscow`. |

Доступны следующие шаблонные переменные:

| Переменная | Описание |
| :---: | :--- |
| `{root_dir}` | Корневой каталог программы (полный путь) |
| `{root_drive}` | Диск корневого каталога |
| `{root_path}` | Путь к корневому каталогу программы |
| `{time_zone}` | Временная зона в формате Etc/GMT (см. `time_zone`) |
| `{module_name}` | Имя модуля |

Помимо шаблонных переменных вы можете использовать любые переменные среды окружения Windows, например: `%SYSTEMDRIVE%`, `%USERNAME%`, `%PATH%` и т.д.

### Секция `[environment]` ###
Секция служит для задания/переопределения переменных среды окружения модуля (поддерживаемые переменные зависят от модуля). Для удаления переменной из среды окружения задайте пустое значение.

Доступны следующие шаблонные переменные:

| Переменная | Описание |
| :---: | :--- |
| `{root_dir}` | Корневой каталог программы (полный путь) |
| `{root_drive}` | Диск корневого каталога |
| `{root_path}` | Путь к корневому каталогу программы |
| `{time_zone}` | Временная зона в формате Etc/GMT (см. `time_zone`) |
| `{module_name}` | Имя модуля |
| `{ip}` | IP-адрес(а) модуля (если задано) |
| `{port}` | Порт модуля (если задано) |
| `{log_level}` | Уровень журналирования (если задано) |
| `{query_log_level}` | Уровень журналирования запросов (если задано) |

Помимо шаблонных переменных вы можете использовать любые переменные среды окружения Windows, например: `%SYSTEMDRIVE%`, `%USERNAME%`, `%PATH%` и т.д.

### Секция `[<имя_файла_конфигурации>]` ###
Секции этого типа описывают работу с файлами конфигурации модуля (кол-во секций не ограничено). Шаблоны конфигурации модуля находятся в каталоге `./config/<имя_модуля>/<имя_профиля>/templates`. В процессе запуска модуля шаблоны описанные в таких секциях будут преобразованы во временные рабочие файлы конфигурации.

| Параметр | Обязательный | Описание |
| :---: | :---: | :--- |
| `comment` | да | Символ комментария для использования в файле конфигурации. |
| `destination_dir` | да | Каталог назначения для сохранения временного рабочего файла конфигурации модуля. Файл пересоздаётся при каждом запуске модуля. |
| `enabled` | нет | Включение/выключение использования этого файла конфигурации. Задайте значение `off` если этот файл временно не требуется для работы модуля (по молчанию `on`). |
| `encoding` | нет | Кодировка файла конфигурации (по умолчанию `UTF8`).<br>Допустимые значения `UTF8`, `ANSI`, `ASCII`. |
| `path_separator` | да | Символ-разделитель, используемый в именах путей к нужным ресурсам. |

Доступны следующие шаблонные переменные:

| Переменная | Описание |
| :---: | :--- |
| `{root_dir}` | Корневой каталог программы (полный путь) |
| `{root_drive}` | Диск корневого каталога |
| `{root_path}` | Путь к корневому каталогу программы |
| `{time_zone}` | Временная зона в формате Etc/GMT (см. `time_zone`) |
| `{module_name}` | Имя модуля |
| `{ip}` | IP-адрес(а) модуля (если задано) |
| `{port}` | Порт модуля (если задано) |
| `{log_level}` | Уровень журналирования (если задано) |
| `{query_log_level}` | Уровень журналирования запросов (если задано) |

Помимо шаблонных переменных вы можете использовать любые переменные среды окружения Windows, например: `%SYSTEMDRIVE%`, `%USERNAME%`, `%PATH%` и т.д.

Консоль
----------
![Open Server Panel Console](./resources/cli.png)

Веб-интерфейс
----------
![Open Server Panel Web Interface](./resources/web.png)
