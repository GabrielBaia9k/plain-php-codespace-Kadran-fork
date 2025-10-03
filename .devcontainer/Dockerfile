FROM debian:bullseye-slim

ARG DEBIAN_FRONTEND=noninteractive
USER root
COPY php.ini /tmp

# Update package list
RUN echo "Updating package list" \
    && apt-get update -yq

# Install nano
RUN echo "Installing nano" \
    && apt-get install -y nano
    
# Add updated PHP sources
RUN echo "Adding updated PHP sources" \
    && apt-get install curl -yq \
    && curl -sSL https://packages.sury.org/php/README.txt | bash -x \
    && apt-get update -yq

# Install common packages
RUN echo "Installing common packages" \
    && apt-get install git imagemagick nano openssh-server sqlite3 wget unzip -yq

# Modify ImageMagick policy to allow PDF read/write
RUN echo "Modifying ImageMagick policy to allow PDF read/write" \
    && sed -i 's/<policy domain="coder" rights="none" pattern="PDF" \/>/<policy domain="coder" rights="read|write" pattern="PDF" \/>/g' /etc/ImageMagick-6/policy.xml

# Install PHP CLI with some extensions for Drupal development
RUN echo "Installing PHP CLI with extensions for Drupal development" \
    && apt-get install php8.2-dev php8.2-xml -yq \
    && apt-get install php8.2-apcu php8.2-curl php8.2-gd php8.2-imagick php8.2-mbstring php8.2-sqlite3 php8.2-zip php8.2-mysql -yq

# Ensure pdo_mysql is enabled for PHP 8.2
RUN phpenmod -v 8.2 pdo_mysql

# Configure PHP and install xdebug
RUN echo "Configuring PHP and installing xdebug" \
    && pear config-set php_ini /etc/php/8.2/cli/php.ini \
    && pecl install xdebug \
    && cat /tmp/php.ini >> /etc/php/8.2/cli/php.ini

# Install NodeJS LTS
RUN echo "Installing NodeJS LTS" \
    && curl -sL https://deb.nodesource.com/setup_lts.x | bash \
    && apt-get install nodejs -yq

# Install Composer
RUN echo "Installing Composer" \
    && wget https://getcomposer.org/installer \
    && php installer --install-dir=/usr/local/bin --filename=composer \
    && rm installer

# Install MariaDB
RUN echo "Installing MariaDB" \
    && apt-get install mariadb-server mariadb-client -yq

# Configure MariaDB
RUN echo "Configuring MariaDB" \
    && mkdir -p /var/lib/mysql \
    && chown -R mysql:mysql /var/lib/mysql

# Expose MariaDB port
EXPOSE 3306

# Start MariaDB service in postCreateCommand
CMD ["mysqld"]

# Install Apache2
RUN echo "Installing Apache2" \
    && apt-get install apache2 -yq

# Enable PHP in Apache2
RUN echo "Configuring Apache2 with PHP" \
    && apt-get install libapache2-mod-php8.2 -yq \
    && a2enmod php8.2 \
    && a2enmod rewrite

# Set up Apache2 to serve files from /var/www/html
RUN echo "Setting up Apache2 document root" \
    && mkdir -p /var/www/html \
    && chown -R www-data:www-data /var/www/html

#Redundant
#    RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y \
#    php php-cli php-mysql libapache2-mod-php \
#    mariadb-server mariadb-client \
# && phpenmod pdo_mysql \
# && rm -rf /var/lib/apt/lists/*

# Expose Apache2 port
EXPOSE 80

# Start Apache2 service in postCreateCommand
CMD ["apache2ctl", "-D", "FOREGROUND"]