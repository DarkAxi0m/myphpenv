FROM php:7.0.33-apache
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

RUN apt-get update 
#RUN apt-get upgrade  -y --allow-unauthenticated

#RUN apt-get upgrade -y libapt-pkg5.0 libzstd1 libc6  --allow-unauthenticated
#RUN apt-get upgrade -y libseccomp2  libgnutls30   apt 
#RUN apt-get install -y zlib1g-dev libssl-dev -t buster --allow-unauthenticated
#RUN apt-get upgrade -y openssl   -t buster --allow-unauthenticated
RUN apt-get install -y  ca-certificates --allow-unauthenticated

RUN apt-get update
RUN apt-get install  -y   \
    vim \
    git \
    curl \ 
    zip \ 
    unzip \
    libzip-dev \
    gnupg \
    ghostscript \
    libcurl3-openssl-dev \
    libicu-dev \
    libpng-dev  --allow-unauthenticated
    #apt-transport-https \
    # ca-certificates \
RUN curl -sS https://getcomposer.org/installer | php \
    && chmod +x composer.phar && mv composer.phar /usr/local/bin/composer \  
    && docker-php-ext-install zip opcache intl exif gd \
    && docker-php-ext-configure gd \
        --with-freetype \
        --with-jpeg \
    && docker-php-ext-install mysqli pdo_mysql && docker-php-ext-enable mysqli pdo_mysql \
    && a2enmod rewrite  
    
    
    





RUN pecl install -o -f redis \
&&  rm -rf /tmp/pear \
&&  docker-php-ext-enable redis

RUN sed -ri -e 's!/var/www/html!${APACHE_DOCUMENT_ROOT}!g' /etc/apache2/sites-available/*.conf \
 && sed -ri -e 's!/var/www/!${APACHE_DOCUMENT_ROOT}!g' /etc/apache2/apache2.conf /etc/apache2/conf-available/*.conf
COPY dockersrc/opcache.ini $PHP_INI_DIR/conf.d/opcache.ini
COPY dockersrc/docker-php-ext-redis.ini $PHP_INI_DIR/conf.d/docker-php-ext-redis.ini

