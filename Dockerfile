FROM php:8.2-apache

# Instala extensões necessárias (sem módulo problemático)
RUN docker-php-ext-install mysqli pdo pdo_mysql

# Copia os arquivos
COPY . /var/www/html/

# Define permissões
RUN chown -R www-data:www-data /var/www/html && \
    chmod -R 755 /var/www/html

# Porta padrão do Railway
ENV PORT=8080

# Expõe a porta
EXPOSE 8080

# Inicia o Apache
CMD ["apache2-foreground"]
