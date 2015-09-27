docker stop onlyoffice-community-server onlyoffice-mail-server onlyoffice-document-server
docker rm   onlyoffice-community-server onlyoffice-mail-server onlyoffice-document-server

NAME_DOC=onlyoffice-document-server
NAME_MAIL=onlyoffice-mail-server
NAME_COMMUNITY=onlyoffice-community-server

NAME_SERVER=office.aflitos.net

DATA_FOLDER=$HOME/data/docker/onlyoffice

OUT_IP=127.0.1.1

PORT_OUT=$OUT_IP:8888
PORT_OUT_TSL=$OUT_IP:4443
PORT_OUT_SEC=$OUT_IP:5222
PORT_MAIL=$OUT_IP:25
PORT_MAIL_TSL=$OUT_IP:143
PORT_MAIL_SEC=$OUT_IP:587

DNS="--dns=208.67.220.220 --dns=8.8.4.4 --dns=208.67.222.222 --dns=8.8.8.8"
DNS=""

docker run -i -t -d              --name $NAME_DOC                    \
	-v $DATA_FOLDER/docs/data:/var/www/onlyoffice/Data           \
	-v $DATA_FOLDER/docs/logs:/var/log/onlyoffice                \
	$DNS                                                         \
	onlyoffice/documentserver
#	-v $DATA_FOLDER/docs:/var/www/onlyoffice/Data \

docker run -i -t -d --privileged --name $NAME_MAIL                   \
        -p $PORT_MAIL:25 -p $PORT_MAIL_TSL:143 -p $PORT_MAIL_SEC:587 \
	-h mail.$NAME_SERVER                                         \
	$DNS                                                         \
	-v $DATA_FOLDER/mail/server:/etc/pki/tls/mailserver          \
	-v $DATA_FOLDER/mail/vmail:/var/vmail                        \
	-v $DATA_FOLDER/mail/log:/var/log                            \
	-v $DATA_FOLDER/mail/httpd:/etc/httpd/logs/                  \
	-v $DATA_FOLDER/mail/mysql:/var/lib/mysql                    \
	onlyoffice/mailserver

docker run -i -t -d              --name $NAME_COMMUNITY              \
	-p $PORT_OUT:80  -p $PORT_OUT_TSL:443  -p $PORT_OUT_SEC:5222 \
	-h $NAME_SERVER                                              \
	$DNS                                                         \
	-v $DATA_FOLDER/community/data:/var/www/onlyoffice/Data      \
	-v $DATA_FOLDER/community/log:/var/log/onlyoffice            \
	-v $DATA_FOLDER/community/mysql:/var/lib/mysql               \
	--link $NAME_DOC:document_server                             \
	onlyoffice/communityserver
#	--link $NAME_MAIL:mail_server                                \


