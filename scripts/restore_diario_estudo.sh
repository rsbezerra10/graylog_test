#!/bin/bash

DATA=`date +%d.%m.%Y`
SIAP="siapgeo-$DATA.fbk.gz"
DESTINO="/BACKUP"
ORIGEM="/media/STORAGE"
   
echo "Iniciando a Cópia do banco $SIAP"
cp $ORIGEM/$SIAP $DESTINO 
echo "Copia do BACKUP Conluido"



BACKUP="/media/STORAGE/"
DATA=`date +%d.%m.%Y`
#DATA="27.12.2016"
SIAP="siapgeo-$DATA.fbk.gz"
ORIGEM=`find $BACKUP | grep $SIAP`
export DESTINO="/databases/"
GBAK="/opt/firebird/bin/gbak"
DIARIO="SIAPGEO_DIARIO.FDB"

# Encerrando os processos em execução;
fuser -k $DESTINO$DIARIO

cd $DESTINO
# Verifica se ja existe o arquivo descompactado;
if [ -a siapgeo-$DATA.fbk ]
#if [ siapgeo-$DATA.fbk ]
 then
   echo "Arquivo já existe -> `date +%H:%M:%S`"
   echo "Arquivo já existe -> `date +%H:%M:%S`" >> erro.log
 else	
   # Verifica se já existe uma copia do backup atualizado;
   if [ -a $SIAP ]
  # if [ $SIAP ]
     then
       echo "Arquivo de backup $SIAP ja existe. -> `date +%H:%M:%S`"
       echo "Arquivo de backup $SIAP ja existe. -> `date +%H:%M:%S`" >> erro.log
     else
       if [ -z $ORIGEM ]
         then
	   echo "Backup não encontrado -> `date +%H:%M:%S`"
	   echo "Backup não encontrado -> `date +%H:%M:%S`" >> erro.log
	   sleep 2
	   exit
       else	
    	   echo "Backup $ORIGEM encontrado. -> `date +%H:%M:%S`"
	   echo "Backup $ORIGEM encontrado. -> `date +%H:%M:%S`" >> erro.log
	   echo "Iniciando a copia do banco de dados -> `date +%H:%M:%S`"
	   echo "Iniciando a copia do banco de dados -> `date +%H:%M:%S`" >> erro.log
	   cp $ORIGEM $DESTINO
	   echo "Copia efetuada. -> `date +%H:%M:%S`"
	   echo "Copia efetuada. -> `date +%H:%M:%S`" >> erro.log
		
	   # Verifica se copiou o backup;
	   if [ -a $SIAP ] 
	     then
	       # Removendo o banco obsoleto;
	       if [ -a $DIARIO ]
	         then
		   echo "Removendo o banco $DIARIO obsoleto... -> `date +%H:%M:%S`"
		   echo "Removendo o banco $DIARIO obsoleto... -> `date +%H:%M:%S`" >> erro.log
		   rm $DIARIO	
	         else
		   echo "Banco $DIARIO não encontrado -> `date +%H:%M:%S`"
		   echo "Banco $DIARIO não encontrado -> `date +%H:%M:%S`" >> erro.log
               fi
	       # Descompactando o Backup;
	       echo "Iniciando a descompactacao do banco -> `date +%H:%M:%S`"
	       echo "Iniciando a descompactacao do banco -> `date +%H:%M:%S`" >> erro.log
	       cd $DESTINO
	       gzip -d $SIAP
	     else
    	       echo "Arquivo de backup $SIAP nao encontrado -> `date +%H:%M:%S`"
    	       echo "Arquivo de backup $SIAP nao encontrado -> `date +%H:%M:%S`" >> erro.log
    	       sleep 2
    	       exit
    	   fi	
    	fi								
   fi
fi
	

# Verifica se o banco foi descompactado com sucesso;
if [ -a siapgeo-$DATA.fbk ]
  then
    echo "Banco descompactado -> `date +%H:%M:%S`"
    echo "Banco descompactado -> `date +%H:%M:%S`" >> erro.log
    # Inicia processo de importacao do banco de dados;
    echo "Iniciando a importação do banco de dados siapgeo-$DATA.fbk -> `date +%H:%M:%S`"
    echo "Iniciando a importação do banco de dados siapgeo-$DATA.fbk -> `date +%H:%M:%S`" >> erro.log
    #/etc/init.d/xinetd stop
    $GBAK -R -V -Y $DESTINO/RESTAURACAO-$DATA.LOG siapgeo-$DATA.fbk $DIARIO 
    chmod 660 $DIARIO
    chown firebird:firebird $DIARIO
    #/etc/init.d/xinetd start
    echo "Banco $DIARO restaurado. -> `date +%H:%M:%S`"
    echo "Banco $DIARO restaurado. -> `date +%H:%M:%S`" >> erro.log
  else
    echo "Erro na descompactação -> `date +%H:%M:%S`"
    echo "Erro na descompactação -> `date +%H:%M:%S`" >> erro.log
    rm siapgeo-$DATA.fbk
    rm siapgeo-$DATA.fbk.gz
    echo "Backup temporario removido -> `date +%H:%M:%S`"	
    echo "Backup temporario removido -> `date +%H:%M:%S`" >> erro.log
    echo "" >> erro.log
    echo "" >> erro.log
    exit 
fi		

# Removendo o backup temporario se o banco foi restaurado com sucesso;
if [ -a $DIARIO ]
  then
    if [ -a siapgeo-$DATA.fbk ]
      then
        rm siapgeo-$DATA.fbk
	rm siapgeo-$DATA.fbk.gz
	echo "Backup temporario removido -> `date +%H:%M:%S`"	
	echo "Backup temporario removido -> `date +%H:%M:%S`" >> erro.log
	echo "" >> erro.log
	echo "" >> erro.log
      else
  	echo "Backup temporario nao encontrado -> `date +%H:%M:%S`"				
	echo "Backup temporario nao encontrado -> `date +%H:%M:%S`" >> erro.log			
	echo "" >> erro.log
	echo "" >> erro.log
      fi
fi
