# Utilizar la imagen base de ubuntu
FROM ubuntu:latest

#Instala nginx como servidor web

FROM nginx:latest
COPY ./nginx/nginx.conf /etc/nginx/conf.d/default.conf
COPY --from=build /app/build /usr/share/nginx/html

# Utilizar la imagen oficial de Node.js como imagen base
FROM node:latest

# Establecer el directorio de trabajo en el contenedor para el backend
WORKDIR /usr/src/app/backend

# Copiar el 'package.json' y 'package-lock.json' del backend
COPY Backend/package*.json ./

# Instalar las dependencias del backend
RUN npm install

# Copiar el resto del código fuente del backend
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

# Cambiar de nuevo al directorio del backend para la ejecución
WORKDIR /usr/src/app/backend

FROM nginx
COPY Frontend/src/app/app.component.html /usr/share/nginx/html

# Exponer el puerto 3000 para el servidor Node.js y el puerto 80 para el servidor Nginx
EXPOSE 3000 80

FROM ubuntu:latest

# Instalar Node.js y npm
RUN apt-get update && \
    apt-get install -y nodejs npm

# Copiar el archivo del servidor Node.js
COPY Backend/index.js /app/index.js

# Establecer el directorio de trabajo
WORKDIR /app

# Instalar dependencias del proyecto, si las hay
#COPY package.json /app/
#RUN npm install

# Exponer el puerto 3000
EXPOSE 3000

# Comando para iniciar el servidor Node.js
CMD node index.js
