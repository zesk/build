# Simple Application

Copyright &copy; 2024 Market Acumen, Inc.

This application does nothing spectacular except:

- Sets up a cron task to run every minute which updates a file
- Sets up a service which runs at all times and generates IDs
- Sets up a web site which delivers state of the above as well as the deployment environment
- Deploy with environment: APPLICATION_PORT

The data can be accessed via the home page of the site which can be served in any number of ways.

The `.webApplication` directory is operated on by two support scripts on the host system:

- `crontab-application-sync.sh` for the crontab updates
- `installApacheConfiguration` a script for apache configuration files (WIP)
- `installServices` a script for `daemontools` service running (WIP)
