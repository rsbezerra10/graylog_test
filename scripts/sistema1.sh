#!/bin/bash

#estrutura graylog
sistema="[SISTEMA1] "
graylog_server="172.17.1.245 12201"

informe="Tabela1 acessada por usuario1 - `date +%H:%M:%S`"
message=$sistema$informe
echo $message
echo -n $message | nc -w0 -u $graylog_server

informe="Relatório de teste impresso por usuario1 -  `date +%H:%M:%S`"
message=$sistema$informe
echo $message
echo -n $message | nc -w0 -u $graylog_server

informe="Sessão encerrada usuario1 -  `date +%H:%M:%S`"
message=$sistema$informe
echo $message
echo -n $message | nc -w0 -u $graylog_server
