# Wireguard + Nginx

Configuration files for [wg-easy](https://github.com/wg-easy/wg-easy) installation with Nginx reverse proxy.


Directory structure
```
├── compose.yaml
└── nginx
    ├── cf_client_certs
    │   ├── cloudflare.pem
    │   ├── hostname.com_cert.pem
    │   └── hostname.com_key.pem
    └── servers
        └── hostname.com.conf
```

Obtain TLS certificates from Cloudflare or Letsencrypt and place them in `cf_client_certs`,
update password in `compose.yaml`, then change hostnames everywhere:
```
# for example, if wireguard hostname is wg.company.com
for f in compose.yaml nginx/servers/hostname.com.conf ; do sed -i 's/hostname.com/wg.company.com/g' $f; done
mv nginx/servers/hostname.com.conf nginx/servers/wg.company.com.conf
```

and run containers:
```
docker compose up -d
```
