# Instalacion del CMS Wordpress sobre LAMP
1. Instalar paquetes php necesarios.
   ```
   apt install php-curl php-gd php-mbstring php-xml php-xmlrpc php-soap php-intl php-zip
   ```
    ![](img/cap1.png)

2. Creacion y configuracion de la base de datos que utilizara wordpress.
   ``` 
   mariadb -u root -p
   ```
   ```
   create database wordpress;
   use wordpress;
   create user 'wp_user203'@’localhost’ identified by 'alumno203';
   grant all privileges on wordpress.* to 'wp_user203'@’localhost’ with grant option;
   flush privileges;
   quit;
   ```
   ![](img/cap2.png)
   ![](img/cap3.png)
   ![](img/cap4.png)

3. Configuracion de apache
   - Modificar el archivo 000-default.conf 
   ```
   cd /etc/apache2/sites-aviable
   nano 000-default.conf
   ``` 
   ![](img/cap5.png)
   Tiene que quedar como el de la siguiente imagen.
   ![](img/cap6.png)
   - Activar el mod_rewrite para usar la funcion de enlace permante.
   ```
   a2enmod rewrite
   ``` 
   ![](img/cap7.png)
4. Descargar e instalar Wordpress
   - Instalar el paquete wget.
        ```
        apt install wget -y
        ``` 
        ![](img/cap8.png)
   - Descargar wordpress utilizando wget.
        ```
        wget https://es.wordpress.org/latest-es_ES.zip -P /tmp

        ```
        ![](img/cap9.png)
   - Instalar la herramienta unzip
        ```
        apt install unzip -y
        ```
        ![](img/cap10.png)
   - Descomprimir el archivo zip de wordpress
        ```
        cd /tmp
        unzip latest-es_ES.zip
        ```
        ![](img/cap11.png)
   - Mover el contenido descargado y descomprimido a /var/www/html, cambiar el usuario pripetario y reiniciar apache2.
        ```
        mv -f /tmp/wordpress/* /var/www/html
        sudo chown -R www-data:www-data /var/www/html
        sudo systemctl restart apache2
        ```
        ![](img/cap12.png)
   - Terminar de configurar wordpress en el navegador y una vez terminado   aparecera la pagina inicial de wordpress
        ![](img/cap13.png)