# Conan Exiles Server Updater

This simple shell script checks your (Docker-based) Conan Dedicated Server and restarts it if there is an update available and no one is playing

## ASSUMPTIONS
This script makes a couple assumptions about your environment:
* You are using a docker container to run your server (I recommend [this one](https://github.com/melle2/conanexiles-ds))
* You're cool with running cron jobs
* Your server is sparse enough that there are windows where no one is playing

## USAGE
1. Edit the variables to match those of your specific environment
2. Place the script somewhere easy for you to remember (perhaps alongside the config folders for your server?)
3. Run `sudo crontab -e` and add this script to run on a schedule that works for your server.  Optionally, end the execution of the script with `>> /var/log/conanupdates.log` to have the output logged

## TO-DOs
* Maybe add a feature to flag automatic update scheduling, with broadcast messages via RCON if possible?
