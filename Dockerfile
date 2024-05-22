# Usar Ubuntu como imagen base
FROM ubuntu:latest

# Instalar nginx, Node.js y npm
RUN apt-get update && \
    apt-get install -y nginx nodejs npm curl

# Instalar Angular CLI
RUN npm install -g @angular/cli

# Configurar el directorio de trabajo para la aplicación Angular
WORKDIR /app

# Copiar el archivo de la aplicación Angular al contenedor
COPY . /app

# Instalar dependencias de Node para la aplicación Angular
RUN npm install

# Construir la aplicación Angular
RUN ng build --prod

FROM nginx
COPY Frontend/src/app/app.component.html /usr/share/nginx/html

# Exponer el puerto 80 para Nginx
EXPOSE 80

# Comando para iniciar Nginx en el frente y mantener el contenedor en ejecución
CMD ["nginx", "-g", "daemon off;"]