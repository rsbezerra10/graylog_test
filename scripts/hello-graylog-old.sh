#!/bin/bash

#estrutura graylog
version='"1.1"'
host='"host-test"'
short_message='"HELLO GRAYLOG "'
level="5"
some_info='"teste"'
graylog_server="172.17.1.245 12201"

#msg='{ version:'$version', host:'$host', short_message: '$short_message', level:'$level' ,_some_info: '$some_info' }'

informe="PASSO1 ==> concluido."
  echo $informe
  short_message=$informe
  msg='{version:'$version', host:'$host', short_message: '$short_message', level:'$level' ,_some_info: '$some_info'}'
#echo $msg
echo -n $msg | nc -w0 -u $graylog_server

echo "PASSO2 ==> concluido."
        short_message='"PASSO2 ==> concluido."'
        msg='{version:'$version', host:'$host', short_message: '$short_message', level:'$level' ,_some_info: '$some_info'}'
echo -n $msg | nc -w0 -u $graylog_server


echo "PASSO3 ==> Falha i/o."
        short_message='"PASSO3 ==> Falha i/o."'
        msg='{version:'$version', host:'$host', short_message: '$short_message', level:'$level' ,_some_info: '$some_info'}'
echo -n $msg | nc -w0 -u $graylog_server


echo "PASSO4 ==> concluido."
        short_message='"PASSO4 ==> concluido."'
        msg='{version:'$version', host:'$host', short_message: '$short_message', level:'$level' ,_some_info: '$some_info'}'
echo -n $msg | nc -w0 -u $graylog_server


#echo -n '{"version": "1.1", "host": "example.org", "short_message": "Hello World", "level": 5, "_some_info": "foo" }' | nc -w0 -u 172.17.1.245 12201

