{environment}
if /i not "{terminal_codepage}"=="" if /i not "%1"=="shell" set "OSP_CODEPAGE={terminal_codepage}" & if defined OSP_TMP_CODEPAGE set "OSP_TMP_CODEPAGE={terminal_codepage}"
if /i not "%1"=="add" set "OSP_ACTIVE_ENV={module_name}" & set "OSP_ACTIVE_ENV_VAL=:{module_name}:"
if /i "%1"=="add" set "OSP_ACTIVE_ENV=%OSP_ACTIVE_ENV% + {module_name}" & set "OSP_ACTIVE_ENV_VAL=%OSP_ACTIVE_ENV_VAL%:{module_name}:"
if not defined OSP_PSV if not exist "{root_dir}\temp\{module_name}.lock" echo: & echo %_ESC_%[93m{lang_17}: {module_name} {lang_172}%_ESC_%[0m
if /i not "%1"=="shell" if /i not "%3"=="silent" echo: & echo {lang_52}: %OSP_ACTIVE_ENV%
if /i not "%1"=="shell" TITLE %OSP_ACTIVE_ENV% ^| Open Server Panel
