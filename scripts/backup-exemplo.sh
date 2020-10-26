#!/bin/bash

#estrutura graylog
sistema="[BACKUP-EXEMPLO] "
graylog_server="172.17.1.245 12201"

informe="Cópia de arquivo exemplo efetuada com sucesso."
message=$sistema$informe
echo $message
echo -n $message | nc -w0 -u $graylog_server

informe="Compactacao de arquivo exemplo realizada."
message=$sistema$informe
echo $message
echo -n $message | nc -w0 -u $graylog_server

informe="Envio de arquivo para platafoma de backup realizado com sucesso."
message=$sistema$informe
echo $message
echo -n $message | nc -w0 -u $graylog_server


informe="Arquivo recebido, bkp de teste concluido."
message=$sistema$informe
echo $message
echo -n $message | nc -w0 -u $graylog_server
