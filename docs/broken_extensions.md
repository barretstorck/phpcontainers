# Broken Extensions Report

The following extensions are currently failing to build or verify.

## 1. db2
*   **Status:** Fails Build
*   **OS:** Debian (tested on `8.4-cli`)
*   **Error:**
    ```
    fatal error: sqlcli1.h: No such file or directory
    ```
*   **Cause:** The `docker-php-ext-configure` command is failing to add `/clidriver/include` to the compiler's include path, despite the `--with-IBM_DB2=/clidriver` flag.
*   **Attempted Fix:** Exporting `IBM_DB2_HOME=/clidriver` was attempted but did not resolve the issue.
*   **Next Steps:**
    *   Investigate if `C_INCLUDE_PATH` or `CFLAGS` needs to be explicitly set.
    *   Verify the directory structure of the downloaded `driver.tar.gz` to ensure headers are exactly where expected.
