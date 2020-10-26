#!/bin/bash

#estrutura graylog
sistema="[HELLO-GRAYLOG] "
graylog_server="172.17.1.245 12201"

informe="PASSO1 ==> concluido."
message=$sistema$informe
echo $message
echo -n $message | nc -w0 -u $graylog_server

informe="PASSO2 ==> concluido."
message=$sistema$informe
echo $message
echo -n $message | nc -w0 -u $graylog_server

informe="PASSO3 ==> Falha i/o."
message=$sistema$informe
echo $message
echo -n $message | nc -w0 -u $graylog_server


informe="PASSO4 ==> concluido."
message=$sistema$informe
echo $message
echo -n $message | nc -w0 -u $graylog_server
