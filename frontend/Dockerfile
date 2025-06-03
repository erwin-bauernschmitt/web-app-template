#------------------------------------------------------------------------------
# Dockerfile for Front End Container
#
# This Dockerfile uses a two-stage build process to first build a custom React 
# app and then serve all static files through an Nginx server. It is dependent 
# on the Dockerfile for the back end container having collected the static 
# files for Django's admin panel.
#
# Maintainer: erwin-bauernschmitt 
# Last reviewed: 02/06/2025
#------------------------------------------------------------------------------

### STAGE 1 ###

# Use an official Node.js base image running on Alpine Linux
FROM node:22-alpine AS build

# Create a non-root system user called appuser
RUN addgroup -S appuser && adduser -S -D -G appuser -s /bin/sh appuser

# Set the working directory for the build
WORKDIR /app

# Install moreutils for ts 
RUN apk add --no-cache moreutils

# Copy package.json (and package-lock.json if exists already) for dependencies
COPY package*.json ./

# Copy the Vite configurations
COPY vite.config.ts ./

# Install dependencies 
RUN npm install && \
    npm install -D @types/node && \
    npm cache clean --force

# Copy the TypeScript configurations
COPY tsconfig.json tsconfig.node.json  tsconfig.app.json  ./ 

# Copy the app source code
COPY public ./public
COPY src ./src
COPY index.html ./

# Build the React app for production
RUN npm run build

# Expose ports 3000/3001 for Vite Server HMR websockets in Dev Mode
EXPOSE 3000 3001

# Give ownership of the working directory to appuser
RUN chown -R appuser:appuser /app

### STAGE 2 ###

# Use an official Nginx base image running on Alpine Linux
FROM nginx:1.26-alpine AS final

# Create a non-root system user called appuser
RUN addgroup -S appuser && adduser -S -D -G appuser appuser

# Install logrotate
RUN apk add --no-cache logrotate

# Install gettext for envsubst
RUN apk add --no-cache gettext

# Set working directory and ensure appuser owns it
WORKDIR /app
RUN chown appuser:appuser /app

# Ensure /var/log/backend directory exists for appuser
RUN mkdir -p /var/log/nginx && \
    chown appuser:appuser /var/log/nginx && \
    chmod 700 /var/log/nginx

# Create the Nginx cache/temp directories for appuser
RUN mkdir -p /var/cache/nginx && \ 
        chown appuser:appuser /var/cache/nginx

# Create the run directory for the Nginx PID file
RUN mkdir -p /var/run/nginx && \
        chown -R appuser:appuser /var/run/nginx

# Create the /etc/nginx directory for appuser
RUN mkdir -p /etc/nginx/ && \
        chown -R appuser:appuser /etc/nginx/

# Copy custom Nginx configuration file
COPY nginx.template.conf /etc/nginx/nginx.template.conf

# Set ownership and permissions for gunicorn config
RUN chown root:appuser /etc/nginx/nginx.conf
RUN chmod 640 /etc/nginx/nginx.conf

# Switch to appuser
USER appuser

# Copy mkcert SSL certificates into the container
COPY certs/fullchain.pem /etc/nginx/ssl/fullchain.pem
COPY certs/privkey.pem /etc/nginx/ssl/privkey.pem

# Copy the built React app's static files from the build stage
COPY --from=build /app/dist /usr/share/nginx/html

# Copy the Django Admin static files from the backend build stage
COPY --from=backend:latest \
        /home/appuser/django-static /usr/share/nginx/html/django-static

# Copy logrotate configurations
COPY logrotate.conf /app/logrotate.conf

# Expose port 80 and port 443 for HTTP and HTTPS communication with Nginx
EXPOSE 80 443