openssl req -x509 -nodes -newkey rsa:2048 \
  -subj '/C=XX/ST=XXXX/L=XXXX/O=XXXX/OU=XXXX/CN=www.example.com/emailAddress=postmaster@example.com' \
  -addext 'subjectAltName = DNS:local74.dev, DNS:local80.dev, DNS:local81.dev' \
  -keyout certs/host.key \
  -out certs/host.cert

openssl pkcs12 -inkey host.key -in host.cert -export -out host.pfx