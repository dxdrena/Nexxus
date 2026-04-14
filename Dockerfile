FROM php:8.2-apache

RUN a2dismod mpm_event && a2enmod mpm_prefork

RUN docker-php-ext-install mysqli pdo pdo_mysql

RUN sed -i 's/80/${PORT}/g' /etc/apache2/ports.conf /etc/apache2/sites-available/000-default.conf

COPY . /var/www/html/

RUN chown -R www-data:www-data /var/www/html && \
    chmod -R 755 /var/www/html

ENV PORT=8080

EXPOSE 8080

CMD ["apache2-foreground"]