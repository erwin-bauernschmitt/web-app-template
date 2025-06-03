# Dockerfiles Explained 

*Maintainer: erwin-bauernschmitt* \
*Last reviewed: 01/02/2025*

This is an attempt at conceptually explaining how a Dockerfile is used to create a container from a custom image (mainly for myself lol). 

## What is an image?

An image is a read-only template that acts as the instructions for something like Docker Engine to launch a particular container. It contains all of the files and configurations needed to recreate the particular container.

A base image, such as `node:14.20-alpine` or `nginx:1.21.6-alpine`, is an image that is referred to in the Dockerfile by the `FROM` instruction. This causes the image to act as the foundational image that subsequent instructions will extend (until another `FROM` instruction identifies a new foundational image). 

Custom images are created by modifying or extending base images with instructions such as `COPY` or `RUN`. The Dockerfile acts as an instruction manual for the build process of a custom container which can be built using the command `docker build`. 

## Example Dockerfile

This is a two-stage Dockerfile for building the front end container of a web app in a production configuration, where an Nginx server will be serving the static files of a React app.

```dockerfile
# Stage 1: Build the React app
FROM node:18-alpine AS build
WORKDIR /app
COPY package.json package-lock.json ./
RUN npm install && npm cache clean --force
COPY public ./public
COPY src ./src
RUN npm run build

# Stage 2: Set up Nginx to serve the React app
FROM nginx:1.21.6-alpine
COPY nginx.conf /etc/nginx/nginx.conf
COPY --from=build /app/build /usr/share/nginx/html
COPY --from=backend:latest /app/staticfiles /usr/share/nginx/html/static
EXPOSE 80 443
```

### Stage 1

`FROM node:18-alpine AS build` identifies `node:18-alpine` as the base image for a new custom image called `build`. The subsequent five instructions extend this base image in an iterative manner.

The `node:18-alpine` image is downloaded from Docker Hub, which is the default online repository for container images searched by Docker if the image is not already available locally. This particular image refers to the official `node` image maintained by the Node.js team, specifically version `18` of Node.js, with `alpine` specifying that the container runs on Alpine Linux. The configuration is slim and secure, with long-term support from Node.js. This image serves as **Layer 0** of the custom image `build`. 

To execute the `WORKDIR /app` instruction, Docker will start a temporary container using the **Layer 0** image, and then set the working directory for subsequent instructions to `/app` (creating the `/app` folder in the process). Then, the modified container is saved as **Layer 1** of the build image and the temporary container is discarded. 

Similarly, the `COPY package.json package-lock.json ./` instruction is executed by Docker starting a temporary container using the newly created **Layer 1** image, copying `package.json` and `package-lock.json` to the current working directory (now `/app`), saving the modified container's image as **Layer 2**, and then discarding the temporary container. 

This process is repeated until the final instruction of Stage 1, where `RUN npm run build` actually builds the React app in an optimised manner, with the generated static files being stored in the `/app/build` folder. This container is then saved as **Layer 5** of the `build` image and the container is discarded. 

### Stage 2

`FROM nginx:1.21.6-alpine` identifies `nginx:1.21.6-alpine` as the new base image for subsequent instructions, isolating the environment for modifying this Nginx image from the previous base image and its modifying instructions. This image serves as **Layer 0** of the custom image that will ultimately be the final output of the Dockerfile. 

The `COPY nginx.conf /etc/nginx/nginx.conf` instruction is executed by Docker starting a temporary container using the **Layer 0** base image, copying `nginx.conf` to the folder `/etc/nginx` (where the copied file is also called `nginx.conf`), saving the modified container's image as **Layer 1**, and then discarding the temporary container.

The `COPY --from=build /app/build /usr/share/nginx/html` instruction is executed by Docker starting a temporary container using the **Layer 1** image from Stage 2, and then copying the `/app/build` folder (with the React app's static files) from **Layer 5** of the `build` image from Stage 1 into the folder `/usr/share/nginx/html`. This modified container is then saved as **Layer 2** of the Nginx image, effectively merging the Node.js outputs of Stage 1 into the production Nginx image in Stage 2. The temporary container is then discarded. 

The `COPY --from=backend:latest /app/staticfiles /usr/share/nginx/html/static` instruction is executed by Docker starting a temporary container using the **Layer 2** image from Stage 2, and then copying the `/app/staticfiles` folder (with the Django Admin static files) from the final layer of the back end image into the folder `/usr/share/nginx/html/static`. This modified container is then saved as **Layer 3** of the Nginx image, effectively merging the static file outputs of the back end container's build process into the production Nginx image in Stage 2. The temporary container is then discarded. 

Finally, the `EXPOSE 80 443` instruction is similarly executed by Docker starting a temporary container using **Layer 3** of the Nginx image, configuring port 80 and port 443 as the intended ports for HTTP and HTTPS traffic respectively, saving the modified container's image as **Layer 4** of the Nginx image, and then discarding the temporary container. 

### Outputs

**Layer 4** of the Nginx image represents the final output of the Docker build process. Docker can start a container using this image, which will contain all of the React app's static files and all of the configurations needed to start an Nginx server to serve these static files through port 80. This can be done using `docker run` or with tools such as `docker-compose up`. 

All other images (including previous layers of the Node.js and the Nginx images) are cached for faster rebuilding unless they are deleted with `docker image prune`.