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
