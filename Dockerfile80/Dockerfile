FROM php:8.0.2-apache
LABEL vendor1="Accede Holdings PTY LTD" \
      dockerfile.maintainer2="Chris Chase <chris@accede.com.au>" 

WORKDIR '/var/www'

ENV APACHE_DOCUMENT_ROOT /var/www 

ENV PHP_OPCACHE_ENABLE="1"
ENV PHP_OPCACHE_VALIDATE_TIMESTAMPS="0" 
ENV PHP_OPCACHE_MAX_ACCELERATED_FILES="10000" 
ENV PHP_OPCACHE_MEMORY_CONSUMPTION="192" 
ENV PHP_OPCACHE_MAX_WASTED_PERCENTAGE="10"

ENV DOCKERREDIS=redis


RUN apt-get update && apt-get install  -y   \
     gnupg2


#source for php8.0-odbc/buster
RUN echo "deb https://packages.sury.org/php/ buster main" | tee /etc/apt/sources.list.d/sury-php.list
COPY  dockersrc/apt.gpg /apt.gpg
RUN apt-key add /apt.gpg

RUN apt-get update && apt-get install  -y   \
    vim \
    git \
    curl \ 
    zip \ 
    unzip \
    libzip-dev \
    gnupg \
    ghostscript \
    imagemagick libmagickwand-dev --no-install-recommends \
    libcurl3-openssl-dev \
    unixodbc-dev  \
    libicu-dev \
    libpng-dev \
    php8.0-odbc/buster \
    && curl -sS https://getcomposer.org/installer | php \
    && chmod +x composer.phar && mv composer.phar /usr/local/bin/composer \  
    && pecl install imagick \
    && docker-php-ext-install zip opcache intl exif gd \
    && docker-php-ext-configure gd \
        --with-freetype \
        --with-jpeg \
    && docker-php-ext-install mysqli pdo_mysql && docker-php-ext-enable mysqli pdo_mysql \
    && docker-php-ext-enable imagick \
    && a2enmod rewrite 

RUN pecl install xdebug  

#install SQLSrv PDO Drivers
RUN curl https://packages.microsoft.com/keys/microsoft.asc |  apt-key add -
RUN curl https://packages.microsoft.com/config/ubuntu/16.04/prod.list |  tee /etc/apt/sources.list.d/mssql-tools.list

RUN  apt-get update &&  ACCEPT_EULA=Y apt-get install  -y   \
     mssql-tools  
#clean up a bit
RUN apt-get autoremove -y


RUN echo 'export PATH="$PATH:/opt/mssql-tools/bin"' >> ~/.bash_profile \
 && echo 'export PATH="$PATH:/opt/mssql-tools/bin"' >> ~/.bashrc 

RUN pecl install sqlsrv pdo_sqlsrv 
RUN pecl install -o -f redis \
&&  rm -rf /tmp/pear \
&&  docker-php-ext-enable redis

RUN echo "extension=sqlsrv.so" > $PHP_INI_DIR/conf.d/sqlsrv.ini \ 
 && echo "extension=pdo_sqlsrv.so" > $PHP_INI_DIR/conf.d/sqlsrv.ini \
 && sed -ri -e 's!/var/www/html!${APACHE_DOCUMENT_ROOT}!g' /etc/apache2/sites-available/*.conf \
 && sed -ri -e 's!/var/www/!${APACHE_DOCUMENT_ROOT}!g' /etc/apache2/apache2.conf /etc/apache2/conf-available/*.conf
COPY dockersrc/opcache.ini $PHP_INI_DIR/conf.d/opcache.ini
COPY dockersrc/docker-php-ext-redis.ini $PHP_INI_DIR/conf.d/docker-php-ext-redis.ini
COPY dockersrc/docker-php-odbc.ini $PHP_INI_DIR/conf.d/docker-php-odbc.ini



COPY dockersrc/xdebug.ini $PHP_INI_DIR/conf.d/xdebug.ini

#I don't like this, but it works
RUN  cp /usr/lib/php/20200930/* /usr/local/lib/php/extensions/no-debug-non-zts-20200930/

