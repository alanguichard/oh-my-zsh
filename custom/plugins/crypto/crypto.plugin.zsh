# Encryption functions
ssl_encrypt() {
  openssl aes-256-cbc -a -salt -in $1 -out $2
}
ssl_decrypt() {
  openssl aes-256-cbc -a -d -in $1 -out $2
}

