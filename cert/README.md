# certs

```sh
openssl req -newkey rsa:3072 -new -x509 -days 3652 -nodes -out saml.pem -keyout saml.key
```

```txt
-----
Country Name (2 letter code) [AU]:AR
State or Province Name (full name) [Some-State]:CABA
Locality Name (eg, city) []:Buenos Aires
Organization Name (eg, company) [Internet Widgits Pty Ltd]:Identicum
Organizational Unit Name (eg, section) []:
Common Name (e.g. server FQDN or YOUR name) []:demoapp1
Email Address []:
```
