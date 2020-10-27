#!/bin/bash

sistema="[BKP-GRAYLOG] "
graylog_server="172.17.1.245 12201"

DATA=`date +%d.%m.%Y.%HH%MM`

informe="Iniciando BKP - $DATA"
message=$sistema$informe 
echo $message
echo -n $message | nc -w0 -u $graylog_server


mkdir "/home/rodrigo/graylog/graylog-bkp-$DATA"
cp -r /graylog/data/ "/home/rodrigo/graylog/graylog-bkp-$DATA/graylog_data"
cp -r /graylog/elasticsearch/ "/home/rodrigo/graylog/graylog-bkp-$DATA/graylog_es"
cp -r /graylog/mongodb/ "/home/rodrigo/graylog/graylog-bkp-$DATA/graylog_mongodb"

informe="BKP concluido - $DATA"
message=$sistema$informe
echo $message
echo -n $message | nc -w0 -u $graylog_server
