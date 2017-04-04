#!/bin/bash

set -xeu

source ./env

#https://letsencrypt.readthedocs.io/en/latest/using.html#running-with-docker
#
#COMPOSE_DATA=/home/saulo/docker/data
#NGINX_DIR_CERTS=nginx/certs
#
#LETS_ENCRYPT_ETC=letsencrypt/etc
#LETS_ENCRYPT_LIB=letsencrypt/lib

CMD=$1


echo "CMD                       ${CMD}"
echo "LETS_ENCRYPT_EMAIL        ${LETS_ENCRYPT_EMAIL}"
echo "LETS_ENCRYPT_SERVER_NAME  ${LETS_ENCRYPT_SERVER_NAME}"
echo "LETS_ENCRYPT_DOMAINS      ${LETS_ENCRYPT_DOMAINS}"
echo "LETS_ENCRYPT_DATA         ${LETS_ENCRYPT_DATA}"
echo "LETS_ENCRYPT_ROOT         ${LETS_ENCRYPT_ROOT}"
echo "LETS_ENCRYPT_ETC          ${LETS_ENCRYPT_ETC}"
echo "LETS_ENCRYPT_LIB          ${LETS_ENCRYPT_LIB}"
echo "LETS_ENCRYPT_CERT_NAME    ${LETS_ENCRYPT_CERT_NAME}"
echo "LETS_ENCRYPT_KEY_SIZE     ${LETS_ENCRYPT_KEY_SIZE}"


DOMAINS=""
for d in ${LETS_ENCRYPT_DOMAINS}; do
DOMAINS="${DOMAINS} --domains=${d}"
done


REQ=""
CMD_BASE="--standalone --non-interactive --text --verbose --agree-tos --redirect --hsts --uir --staple-ocsp --must-staple --tls-sni-01-port=443"
CMD_BASE="${CMD_BASE} --rsa-key-size=${LETS_ENCRYPT_KEY_SIZE} --cert-name=${LETS_ENCRYPT_CERT_NAME} --email=${LETS_ENCRYPT_EMAIL}"
#CMD_NEW="certonly --preferred-challenges=tls-sni-01 --standalone-supported-challenges=tls-sni-01 --force-renewal ${CMD_BASE} ${DOMAINS}"
CMD_NEW="certonly --preferred-challenges=tls-sni-01 --force-renewal ${CMD_BASE} ${DOMAINS}"
CMD_RENEW="renew ${CMD_BASE}"




if   [[ "${CMD}" == "help"  ]]; then
REQ="--help plugins"
elif [[ "${CMD}" == "cert"  ]]; then
REQ="${CMD_NEW}"
elif [[ "${CMD}" == "renew" ]]; then
REQ="${CMD_RENEW}"
else
echo "NO COMMAND. CHOOSE BETWEEN help, cert OR renew"
exit 1
fi



docker stop ${LETS_ENCRYPT_SERVER_NAME} || true



if [[ "1" -eq "1" ]]; then

DOCKER_CMD="docker run -it --rm \
        -p 0.0.0.0:443:443 \
        -p 0.0.0.0:80:80 \
        --name certbot \
        -v \"${LETS_ENCRYPT_ETC}:/etc/letsencrypt\" \
        -v \"${LETS_ENCRYPT_LIB}:/var/lib/letsencrypt\" \
        certbot/certbot:latest $REQ"

#        quay.io/letsencrypt/letsencrypt:latest $REQ"

echo DOCKER CMD ${DOCKER_CMD}

eval ${DOCKER_CMD}

fi



sudo bash -c "wget -O - https://letsencrypt.org/certs/isrgrootx1.pem https://letsencrypt.org/certs/lets-encrypt-x1-cross-signed.pem https://letsencrypt.org/certs/letsencryptauthorityx1.pem https://www.identrust.com/certificates/trustid/root-download-x3.html | tee -a ${LETS_ENCRYPT_ROOT}/ca-certs.pem > /dev/null || true"

sudo chown -R $USER:$USER ${LETS_ENCRYPT_ROOT}

find ${LETS_ENCRYPT_ROOT} -type d -exec chmod 700 {} \;
find ${LETS_ENCRYPT_ROOT} -type f -exec chmod 400 {} \;

docker start ${LETS_ENCRYPT_SERVER_NAME} || true

