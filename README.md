# Linux Server Update Script

An executable shell script to automatically update your Ubuntu or Debian server with the latest packages and patches. This script can be run as a cronjob too. It sends you information about your update procedure and if it failed or succeded. Needs ROOT privileges. 

Caution: You may need to intervene on the server yourself if problems occured during the upgrade procedure. 

## Prerequisites
To run this script the following packages are needed:
* mktemp
* aptitude

## Configuration
Do not forget to give the file daily_update_script.sh executable rights. Like this:
```
sudo chmod +x /etc/cron.daily/daily_update_script.sh
```
The script needs ROOT privileges.

## Installation
The script can be run through the command line or through a cronjob.
Example for a cronjob:
```
10 2      * * *  /etc/cron.daily/daily_update_script.sh
```

## Logging
The script saves the output in this log file:
```
/var/log/dailyupdate.log
```

## Authors

* **A. Dridi** - [a-dridi](https://github.com/a-dridi/)


