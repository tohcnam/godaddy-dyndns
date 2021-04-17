#!/bin/bash

############################################################
# Domain settings
DOMAIN="example.com"
SUBDOMAIN="example"
############################################################

############################################################
# GoDaddy API Credentials
GODADDY_API_KEY=""
GODADDY_API_SECRET=""
GODADDY_URL="https://api.godaddy.com/"
############################################################

## Update IPv4 address
myip=`curl -4 -s "https://ifconfig.co"`
dnsdata=`curl -s -X GET -H "Authorization: sso-key ${GODADDY_API_KEY}:${GODADDY_API_SECRET}" "${GODADDY_URL}/v1/domains/${DOMAIN}/records/A/${SUBDOMAIN}"`
gdip=`echo $dnsdata | cut -d ',' -f 1 | cut -d '"' -f 4`
echo "`date '+%Y-%m-%d %H:%M:%S'` - Current External IP is $myip, GoDaddy DNS IP is $gdip"

if [ "$gdip" != "$myip" -a "$myip" != "" ]; then
  echo "IPv4 has changed! Updating on GoDaddy"
  curl -s -X PUT \
	"${GODADDY_URL}/v1/domains/${DOMAIN}/records/A/${SUBDOMAIN}" \
	-H "Authorization: sso-key ${GODADDY_API_KEY}:${GODADDY_API_SECRET}" \
	-H "Content-Type: application/json" \
	-d "[{\"data\": \"${myip}\"}]"
fi

## Update IPv6 address
myip6=`curl -6 -s "https://ifconfig.co"`
dnsdata6=`curl -s -X GET -H "Authorization: sso-key ${GODADDY_API_KEY}:${GODADDY_API_SECRET}" "${GODADDY_URL}/v1/domains/${DOMAIN}/records/AAAA/${SUBDOMAIN}"`
gdip6=`echo $dnsdata6 | cut -d ',' -f 1 | cut -d '"' -f 4`
echo "`date '+%Y-%m-%d %H:%M:%S'` - Current External IP6 is $myip6, GoDaddy DNS IP6 is $gdip6"

if [ "$gdip6" != "$myip6" -a "$myip6" != "" ]; then
  echo "IPv6 has changed! Updating on GoDaddy"
  curl -s -X PUT \
	"${GODADDY_URL}/v1/domains/${DOMAIN}/records/AAAA/${SUBDOMAIN}" \
	-H "Authorization: sso-key ${GODADDY_API_KEY}:${GODADDY_API_SECRET}" \
	-H "Content-Type: application/json" \
	-d "[{\"data\": \"${myip6}\"}]"
fi
