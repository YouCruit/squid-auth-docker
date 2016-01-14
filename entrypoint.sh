#!/bin/bash -eux

mkdir -p /var/cache/squid3
if [[ "${PROXY_PASSWORD:-none}" != "none" ]]; then
	htpasswd -mbc /etc/squid3/passwd proxyuser "${PROXY_PASSWORD}"
else
	echo "Need to provide the environment variable PROXY_PASSWORD"
	exit 1
fi


if grep -q BLOCKLIST /etc/squid3/squid.conf; then
	result=""
	if [[ "${PROXY_ALLOWED_DSTDOMAINS:-x}" != "x" ]]; then
		arr=$(echo $PROXY_ALLOWED_DSTDOMAINS | tr ",;" "\n\n")
		for dstdomain in $arr; do
			result=$(echo -e "$result    acl allowedDomains dstdomain $dstdomain\n")
		done
	else
		echo "You may provide PROXY_ALLOWED_DSTDOMAINS environment variable to limit which domains are accessible"
	fi
	if [[ "$result" == "" ]]; then
		sed '/allowedHosts/d' -i /etc/squid3/squid.conf
	fi
	sed "s/BLOCKLIST/$result/g" -i /etc/squid3/squid.conf
	cat /etc/squid3/squid.conf
fi	

/usr/sbin/squid3 -z

if [[ "${PROXY_DEBUG:-x}" != "x" ]]; then
	/usr/sbin/squid3 -N -d 1
else
	/usr/sbin/squid3 -N
fi

