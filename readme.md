
# Programar Automaçao de Backup

    crontab -e

# Caminho para o script Alfresco (Executado de Seg-Sex as 19h)

    0 19 * * 1-5 /home/backup-alfresco.sh


  /caminho/backup-alfresco.sh: O caminho completo para o seu script

# Neste formato, os campos significam o seguinte:


0: Minuto (0-59)
19: Hora (0-23)
*: Dia do mês (1-31)
*: Mês (1-12)
*: Dia da semana (0-6, onde 0 é domingo e 6 é sábado)

No exemplo acima, o script será executado todos os dias às 19h.
# Salve o arquivo de configuração e saia do editor.

O cron agora executará automaticamente o seu script todos os dias às 19h.
