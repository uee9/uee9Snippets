# uee9Snippets
Code snippets I always need to look up, now all in one place.

## Database connections:
Cross plaftorm connections:

```{R}
is_mac <- Sys.info()["sysname"] == "Darwin"
is_linux   <- Sys.info()["sysname"] == "Linux"
is_win <- Sys.info()["sysname"] == "Windows"

drv = odbc::odbc()

if (is_mac) {
  message("Running on Mac")
  driver="/opt/cloudera/impalaodbc/lib/universal/libclouderaimpalaodbc.dylib"
  suppressWarnings(secrets <- yaml::read_yaml(""))
  
  ## Connection string has all config settings hard coded into the set up. 
  impala <- DBI::dbConnect(drv = drv, 
                         driver = driver, 
                         database = "",
                         port = 21050,
                         host = "",
                         UID = ,
                         PWD = ,
                         authmech = 3,
                         usesasl = TRUE,
                         ssl = TRUE,
                         allowselfsignedservercert = TRUE,
                         timeout = 12)

} else if (is_linux) {
  message("Running on Linux")
  driver <- "/opt/cloudera/impalaodbc/lib/64/libclouderaimpalaodbc64.so"
  
  suppressWarnings(secrets <- yaml::read_yaml(""))

  ## Connection string has all config settings hard coded into the set up. 
  impala <- DBI::dbConnect(drv = drv, 
                         driver = driver, 
                         database = "",
                         port = 21050,
                         host = "",
                         UID = ,
                         PWD = ,
                         authmech = 3,
                         usesasl = TRUE,
                         ssl = TRUE,
                         allowselfsignedservercert = TRUE,
                         timeout = 12)

} else if (is_win) {
  message("Running on Windows.")
  driver = "Cloudera ODBC Driver for Impala"

  impala <- DBI::dbConnect(drv = drv, 
                           dsn = "CDP", 
                           driver = driver, 
                           host = "", 
                           port = 21050, 
                           database = "default")

}

```
## Docker multi-arch container builds:

```{bash}
docker buildx build --platform linux/amd64,linux/arm64 -t {uid}/{project}:{tag} --push .
```

## Using micromamba in a script without needing a system wide mamba installation:

```{bash}
        if [[ "$OSTYPE" == "linux-gnu"* ]]; then
        ## Linux Machines
            if [[ "$(arch)" == "aarch64" ]]; then
                curl -Ls https://micro.mamba.pm/api/micromamba/linux-aarch64/latest |\
                tar -xvj -C "$APP_ROOT/.payloads/" --strip-components=1 bin/micromamba
            elif [[ "$(arch)" == "x86_64" ]]; then
                curl -Ls https://micro.mamba.pm/api/micromamba/linux-64/latest |\
                tar -xvj -C "$APP_ROOT/.payloads/" --strip-components=1 bin/micromamba
            fi
        elif [[ "$OSTYPE" == "darwin"* ]]; then
        # Mac OSX Machines
            if [[ "$(arch)" == "arm64" ]]; then
               curl -Ls https://micro.mamba.pm/api/micromamba/osx-arm64/latest |\
                tar -xvj -C "$APP_ROOT/.payloads/" --strip-components=1 bin/micromamba 
            elif [[ "$(arch)" == "x86_64" ]]; then
               curl -Ls https://micro.mamba.pm/api/micromamba/osx-64/latest |\
                tar -xvj -C "$APP_ROOT/.payloads/" --strip-components=1 bin/micromamba
            fi
        else
          error "Only Unixed-based operating systems are supported! Consider WSL if using Windows!"
          exit 1
        fi

  export MAMBA_ROOT_PREFIX=${APP_ROOT}/micromamba
  eval "$(${APP_ROOT}/.payloads/micromamba shell hook --shell=bash)"

  ${APP_ROOT}/.payloads/micromamba run -n {ENV} < command > [options]

```
