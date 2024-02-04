#!/bin/bash

# Cargar variables de entorno desde el archivo .env
if [ -f .env ]; then
  export $(grep -v '^#' .env | xargs)
else
  echo "El archivo .env no se encuentra. Asegúrate de tenerlo con las variables necesarias."
  exit 1
fi

# Actualizar el sistema
sudo apt update
sudo apt upgrade -y

# Instalar paquetes php necesarios
sudo apt install php-curl php-gd php-mbstring php-xml php-xmlrpc php-soap php-intl php-zip -y

# Crear y configurar la base de datos
sudo mariadb -u root -p"${MARIADB_ROOT_PASSWORD}" -e "CREATE DATABASE IF NOT EXISTS ${MARIADB_DATABASE};"
sudo mariadb -u root -p"${MARIADB_ROOT_PASSWORD}" -e "CREATE USER IF NOT EXISTS'${MARIADB_USER}'@'localhost' IDENTIFIED BY '${MARIADB_PASSWORD}';"
sudo mariadb -u root -p"${MARIADB_ROOT_PASSWORD}" -e "GRANT ALL PRIVILEGES ON ${MARIADB_DATABASE}.* TO '${MARIADB_USER}'@'localhost' WITH GRANT OPTION;"
sudo mariadb -u root -p"${MARIADB_ROOT_PASSWORD}" -e "FLUSH PRIVILEGES;"

# Configurar Apache
sudo sed -i '5i <Directory /var/www/html/>\n AllowOverride All\n </Directory>' /etc/apache2/sites-available/000-default.conf
sudo a2enmod rewrite
sudo systemctl restart apache2

# Descargar e instalar WordPress
sudo apt install wget unzip -y
sudo wget https://es.wordpress.org/latest-es_ES.zip -P /tmp
sudo unzip /tmp/latest-es_ES.zip -d /tmp
sudo mv -f /tmp/wordpress/* /var/www/html
sudo chown -R www-data:www-data /var/www/html
sudo systemctl restart apache2

# Configuración final de WordPress
echo "Accede a tu sitio en el navegador para completar la instalación de WordPress."



