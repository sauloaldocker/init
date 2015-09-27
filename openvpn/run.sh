#!/bin/bash

source setup


docker stop openvpn
docker rm openvpn


docker run --volume=${OVPN_VOL_MAP} -d -p ${OVPN_PORT}:${OVPN_PORT}/udp --name openvpn --cap-add=NET_ADMIN kylemanna/openvpn



#if [[ ! -f "${OVPN_CONFIG}/pki/private/${OVPN_CLIENT_NAME}.key" ]]; then
#rm config/pki/issued/${OVPN_CLIENT_NAME}.crt config/pki/private/${OVPN_CLIENT_NAME}.key config/pki/reqs/${OVPN_CLIENT_NAME}.req
#docker run --volume=${OVPN_VOL_MAP} --rm -it                                                               kylemanna/openvpn easyrsa build-client-full ${OVPN_CLIENT_NAME}
#fi


#if [[ ! -f "${OVPN_CONFIG}/${OVPN_CLIENT_NAME}.ovpn" ]]; then
#docker run --volume=${OVPN_VOL_MAP} --rm                                                                   kylemanna/openvpn ovpn_getclient ${OVPN_CLIENT_NAME} > ${OVPN_CONFIG}/${OVPN_CLIENT_NAME}.ovpn
#fi

