# Authenticated Squid Docker

Minimal docker image with [Squid] that only proxies authenticated requests and (optionally) only to certain domains.

### Usage
```
docker run -e PROXY_PASSWORD=password -p 3128:3128 youcruit/squid-auth
```

When accessing the proxy, proxy user will be ```proxyuser```, and password will be whatever you set in ```PROXY_PASSWORD```

License
----

BSD

   [squid]: <http://www.squid-cache.org/>

