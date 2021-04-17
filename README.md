# GoDaddy DynDNS service
Store and update your dynamic IP (v4/v6) on a GoDaddy domain

This script allows you to updated your dynamic IP (v4 and v6) address to a GoDaddy subdomain. This will provide you a DynDNS service. 

## Usage
- Enter you [GoDaddy API](https://developer.godaddy.com/keys) and domain information in the dyndns.sh file
- Copy this file to a the folder /usr/local/bin/
    - ```cp dyndns.sh /usr/local/bin/dyndns.sh```
- Modify the permissions of the script so only the user running the cronjob is able to read it
    - ```chown root:root /usr/local/bin/dyndns.sh```
    - ```chmod 700 /usr/local/bin/dyndns.sh```
- Create a regual cronjob to automatically renew your ip (in this once per hour)
	- ```0 * * * *    /usr/local/bin/dyndns.sh > /dev/null 2>&1```