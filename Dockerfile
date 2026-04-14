FROM php:8.2-apache

# Remove TODOS os MPMs e ativa só o prefork
RUN a2dismod mpm_event mpm_worker mpm_prefork || true && \
    a2enmod mpm_prefork

# Instala extensões
RUN docker-php-ext-install mysqli pdo pdo_mysql

# Ajusta porta do Railway
RUN sed -i 's/80/${PORT}/g' /etc/apache2/ports.conf /etc/apache2/sites-available/000-default.conf

# Copia arquivos
COPY . /var/www/html/

# Permissões
RUN chown -R www-data:www-data /var/www/html && \
    chmod -R 755 /var/www/html

ENV PORT=8080

EXPOSE 8080

CMD ["apache2-foreground"]