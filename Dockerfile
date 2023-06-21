# Use a imagem oficial do PostgreSQL como a imagem base
FROM postgres

# Define a variável de ambiente para a senha do PostgreSQL
ENV POSTGRES_PASSWORD=123

# Copia um arquivo SQL personalizado para ser executado durante a inicialização do contêiner
COPY init.sql /docker-entrypoint-initdb.d/

# Define a porta em que o PostgreSQL estará escutando
EXPOSE 5432