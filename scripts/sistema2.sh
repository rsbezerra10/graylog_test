#!/bin/bash

#estrutura graylog
sistema="[SISTEMA2] "
graylog_server="172.17.1.245 1514"

informe="Modulo2 atualizado por usuario2 -`date +%H:%M:%S`"
message=$sistema$informe
echo $message
echo -n $message | nc -w0 -u $graylog_server

informe="Versao em producao alterada para 2  por usuario2 - `date +%H:%M:%S`"
message=$sistema$informe
echo $message
echo -n $message | nc -w0 -u $graylog_server

informe="Falha em autenticacao de usuario2 -  `date +%H:%M:%S`"
message=$sistema$informe
echo $message
echo -n $message | nc -w0 -u $graylog_server
