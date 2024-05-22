# Usar Ubuntu como imagen base
FROM ubuntu:latest

# Instalar nginx, Node.js y npm
RUN apt-get update && \
    apt-get install -y nginx nodejs npm curl

# Establecer el directorio de trabajo en el contenedor para el backend
WORKDIR /usr/src/app/backend

# Copiar el 'package.json' y 'package-lock.json' del backend
COPY Backend/package*.json ./

# Instalar las dependencias del backend
RUN npm install

COPY Backend/ .

# Cambiar al directorio del frontend
WORKDIR /usr/src/app/frontend

# Instalar Angular CLI globalmente
RUN npm install -g @angular/cli

# Copiar el 'package.json' y 'package-lock.json' del frontend
COPY Frontend/package*.json ./

# Instalar las dependencias del frontend
RUN npm install

# Copiar los archivos restantes del proyecto frontend
COPY Frontend/ .

# Construir la aplicación Angular para producción
RUN ng build --configuration production

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