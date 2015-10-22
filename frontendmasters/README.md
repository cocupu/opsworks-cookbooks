# frontendmasters recipes

These recipes set up the frontendmasters layer.  They assume that the actual frontendmasters code was deployed by an OpsWorks app. 

## frontendmasters::cronjob

Sets up daily cron job to run the twitter analyzer
Chef adds the cron job to `/var/spool/cron/crontabs/root`

## frontendmasters::setup

Replaces the frontendmasters home directory with a mounted ebs volume
This directory is used by the analyzer script to store its dat repository.  


## frontendmasters::deploy

deploy recipe for frontendmasters twitter analyzer

Sets up symlinks so that things are findable at the necessary locations 

Deploys the analyzer code 