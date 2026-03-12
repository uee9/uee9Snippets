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
