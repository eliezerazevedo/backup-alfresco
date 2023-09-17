#!/bin/bash

# Diretório onde você deseja salvar os arquivos compactados
diretorio_destino="/home/Backup"

# Verifica se o diretório de destino existe, caso contrário, cria-o
if [ ! -d "$diretorio_destino" ]; then
  mkdir -p "$diretorio_destino"
  echo "Diretório de destino $diretorio_destino criado."
fi

# Parar o serviço Docker
sudo systemctl stop docker

# Diretórios que você deseja compactar
diretorios_origem=(
  "/home/dockerfiles/"
  "/var/lib/docker/volumes/postgres-db-volume/"
  "/var/lib/docker/volumes/htfapps-volume/"
  "/var/lib/docker/volumes/docker_letsencrypt/"
  "/var/lib/docker/volumes/alfresco-solr-volume/"
  "/var/lib/docker/volumes/alfresco-content-data-volume/"
)

# Obtém a data atual no formato Dia-Mês-Ano-Hora
data_atual=$(date +"%d-%m-%Y-%H")

# Nome do arquivo compactado com a data atual
nome_arquivo="Backup_Alfresco_$data_atual.tar.gz"

# Nome do arquivo de log dentro do TAR
nome_arquivo_log="compactacao.log"

# Registra a hora de início no log
echo "Hora de início da compactação: $(date +"%T %d-%m-%Y")" > "$diretorio_destino/$nome_arquivo_log"

# Navegue para o diretório de destino
cd "$diretorio_destino" || exit

# Compacta todos os diretórios de origem em um único arquivo tar
tar -czvf "$nome_arquivo" "${diretorios_origem[@]}" 2>> "$diretorio_destino/$nome_arquivo_log"

# Verifique se o processo de compactação foi bem-sucedido
if [ $? -eq 0 ]; then
  echo "Diretórios Docker compactados com sucesso em $diretorio_destino/$nome_arquivo"
else
  echo "Erro ao compactar os diretórios Docker."
fi

# Registra a hora de término no log
echo "Hora de término da compactação: $(date +"%T %d-%m-%Y")" >> "$diretorio_destino/$nome_arquivo_log"

# Mantém apenas os últimos 3 arquivos e remove os mais antigos
ls -t "$diretorio_destino" | tail -n +4 | xargs -I {} rm -f "$diretorio_destino/{}"

# Iniciar o serviço Docker novamente
sudo systemctl start docker
