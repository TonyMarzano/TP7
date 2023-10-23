# Establecemos la imagen base a la última versión de Ubuntu
FROM ubuntu:latest

# Actualizamos el sistema y luego instalamos el servidor web Nginx
RUN apt-get update && apt-get install -y nginx

# Copiamos un archivo HTML y css personalizado al directorio de contenido web de Nginx
COPY index.html /var/www/html
COPY style.css /var/www/html
COPY menu.js /var/www/html
COPY lightbox.js /var/www/html
COPY img /var/www/html/img


# Exponemos el puerto 80 para las solicitudes HTTP
EXPOSE 80

# Crea un directorio para almacenar archivos externos
#RUN mkdir /app

# Iniciamos Nginx en primer plano para que Docker pueda gestionar el proceso
#CMD ["sh", "-c", "cp -r /mnt/* /app/ && nginx -g 'daemon off;'"]
CMD ["nginx", "-g", "daemon off;"]

