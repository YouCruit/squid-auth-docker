# Authenticated Squid Docker

Minimal docker image with [Squid] that only proxies authenticated requests and (optionally) only to certain domains.

### Usage
```
docker run -e HTTP_PROXY_PASSWORD=password -e youcruit/auth-squid
```

When accessing the proxy, proxy user will be ```proxyuser```, and password will be whatever you set in ```HTTP_PROXY_PASSWORD```

License
----

BSD

   [squid]: <http://www.squid-cache.org/>

