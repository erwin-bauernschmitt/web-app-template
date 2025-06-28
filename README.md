# web-app-template

*Maintainer: erwin-bauernschmitt* \
*Last reviewed: 28/06/2025*

This project intends to establish an accelerated process for creating small web apps through the use of a template app that can easily be launched and tested in either a development-friendly or a production-like configuration.

Not having a background in computer science, this project is also an AI-assisted journey of independent learning with the goal of understanding the architecture of simple web apps and how to implement one (this is my first try lol). In this regard, the project also aims to be a sort of guide or lesson, with detailed explanations and justifications for significant code choices, so as to assist my inevitable re-learning of this content when revisiting the template in the future. 

## Table of Contents

- [Design Philosophy](#design-philosophy)
- [Architecture and Features](#architecture-and-features)
- [The Origin Story](#the-origin-story)
- [Tech Stack and Architecture Choices](#tech-stack-and-architecture-choices)
    - [High-Level Architecture](#high-level-architecture)
    - [Front End](#front-end)
    - [Back End](#back-end)
    - [Database](#database)
- [How to Use](#how-to-use)
    - [The Software Requirements](#the-software-requirements)
    - [Getting Started Locally](#getting-started-locally)
    - [Self-Signed Certs for Local HTTPS Testing](#self-signed-certs-for-local-https-testing)
    - [Setting Up Your Front End's JS Packages](#setting-up-your-front-ends-js-packages)
    - [Creating Your Project's Repo](#creating-your-projects-repo)
    - [Using Development Mode](#using-development-mode)
    - [Using Production Mode](#using-production-mode)
    - [Web App Deployment](#web-app-deployment)
- [Future Work](#future-work)


## Design Philosophy

To maximise utility, the design of this web app template aims to abide by the following principles:

- **Adaptibility:** the template must be comprehensive and flexible enough to accommodate a wide range of web app ideas.
- **Portability:** the template must be capable of development and deployment on different systems without requiring significant debugging or technical expertise.
- **Usability:** the template must be easy to learn, understand, and use through good design and good documentation, both in development and deployment.
- **Affordability:** the template must be capable of being developed into a web app and deployed on a small scale for a low cost (<$100).
- **Modularity:** components of the template must be ready to use, simple to connect, and capable of being developed relatively independently.
- **Scalability:** if necessary, the web app must be capable of being scaled up to support higher demand without requiring a major overhaul of the template's architecture.
- **Security:** although this requires significant expertise, the template should not have obvious or unnecessary security vulnerabilities.


## Architecture and Features

This web app template has a containerised architecture with three **Docker** containers: a **React** front end, a **Django** back end, and a **Postgres** database. These containers are networked through **Docker Compose**. The app can be locally launched and tested in either **Development Mode** or **Production Mode** using simple `make` commands. The development configuration is optimised to make code changes as easy as possible to implement and debug. The production configuration is optimised for testing code in a near-production environment and simplifying the deployment process. 

The following table outlines the key differences between the development and production configurations of the web app template.

| Feature              | Development Mode   | Production Mode    |
|----------------------|:------------------:|:------------------:|
| **Makefile Command** |                    |                    |
| Build & Launch       | `make dev`         | `make prod`        |
| **React Front End**  |                    |                    |
| Optimised Build      | &#10008;           | &#10004;           |
| Live Code Editing    | &#10004;           | &#10008;           |
| Hot Reloading        | &#10004;           | &#10008;           |
| Server               | Vite Dev Server    | Nginx              |
| HTTPS                | &#10004;           | &#10004;           |
| HTML Redirect        | &#10008;           | &#10004;           |
| Reverse Proxying     | &#10008;           | &#10004;           |
| Request Size Limit   | &#10008;           | &#10004;           |
| Request Rate Limit   | &#10008;           | &#10004;           |
| Exposed Port         | 3000               | 443                |
| Process User         | appuser (Non-Root) | appuser (Non-Root) |
| **Django Back End**  |                    |                    |
| Django Debug Mode    | &#10004;           | &#10008;           |
| Live Code Editing    | &#10004;           | &#10008;           |
| Hot Reloading        | &#10004;           | &#10008;           |
| Django Dev Toolbar   | &#10004;           | &#10008;           |
| Automated Migrations | &#10004;           | &#10004;           |
| Server               | Django Dev Server  | Gunicorn           |
| Exposed Port         | 8000               | Not Exposed        |
| Process User         | appuser (Non-Root) | appuser (Non-Root) |
| **Postgres Database**|                    |                    |
| Data Persistence     | Bind Mount         | Named Volume       |
| Startup Healthcheck  | &#10004;           | &#10004;           |
| Exposed Port         | 5432               | Not Exposed        |
| Process User         | postgres (Non-Root)| postgres (Non-Root)|
| **Logging Features** |                    |                    |
| Logging Enabled      | &#10004;           | &#10004;           |
| Log Level            | Debug              | Info               |
| Log Rotation         | &#10008;           | &#10004;           |
| Log Persistence      | Bind Mount         | Named Volume       |


## The Origin Story

For a detailed account of how `web-app-template` was created, including what files were added and what modifications were made to auto-generated files, please see [ORIGIN_STORY.md](./notes/ORIGIN_STORY.md).


## Tech Stack and Architecture Choices

### High-Level Architecture 

<details open>
<summary>This web app template has a Dockerised architecture.</summary>

- By using Docker, the template should be easily portable to different systems, avoiding "works on my machine" problems.
- Development and deployment on a small scale should be simple and low-cost. 
- The modular architecture should simplify development of the different app services by maintaining some functional independence. 
- With a containerised architecture, future web apps could potentially manage resources quickly and efficiently through the use of horizontal scaling and load balancing.
</details>

<details open>
<summary>The template includes a front end service, a back end service, and a database service.</summary>

- Having these three services in the skeleton of the template should make the template adaptable to a wide range of web app ideas. 
- By providing a template for each service, the web app template can be extended into a functional app quickly and easily. 
</details>

<details open>
<summary>The containers are networked with Docker Compose.</summary>

- This template uses Docker Compose instead of alternative approaches like orchestration with Kubernetes due to the smaller learning curve and ease of use.
- The containers communicate over a private network, keeping things tidy and secure.
</details>

<details open>
<summary>The template can be launched in either Production Mode or Development Mode.</summary>

- Development Mode configures the containers to use development servers for live reloading, bind mounts for increased file accessibility, and exposed ports for easier communication. This allows for faster iteration and debugging.
- Production Mode configures the containers for performance and security. This allows for testing in a setup that closely mimics deployment.
</details>

<details open>
<summary>The template has a Makefile that automates building and launching the web app.</summary>

- The makefile simplifies and speeds the process of starting the app.
- It allows easy switching between Development Mode and Production Mode.
- It also ensures that the correct configuration and environment files are used.  
</details>


### Front End

<details open>
<summary>The front end of the web app template includes a React app template.</summary>

- React is a free and open-source front end JavaScript library that is maintained by Meta. 
- It uses a component-based architecture. Since these components are self-contained and can be integrated together into a single-page UI, components from different web applications can be reused, boosting usability. 
- React is very widely used, has a large ecosystem, and is very flexible. 
- Since it is primarily concerned with the design of UIs, other aspects of the front end such as routing and state management can be handled with additional libraries as needed. 
</details>

<details open>
<summary>The React app template was bootstrapped with Vite.</summary>

- Vite is faster and more lightweight than older tools like Create React App.
- Vite supports TypeScript natively. 
- The Vite React app template comes with the Vite Dev Server and SWC.
</details>

<details open>
<summary>The React app template is written in TypeScript.</summary>

- TypeScript adds static typing to JavaScript, which helps with catching bugs early and makes the code easier to scale and maintain.
- TypeScript experience is increasingly in demand.
</details>


#### Front End in Production Mode:

<details open>
<summary>An optimised build of the React app is used.</summary>

- This reduces the size of the React app and improves how quickly it can be served.
</details>

<details open>
<summary>A two-stage build process is used.</summary>

- The build stage can use a Node.js image that has LTS and the build outputs can be copied to an Nginx image. 
- This keeps the final image size small and eliminates any unnecessary build tools, reducing the front end's attack surface.
- It also enables an official Nginx image running on Alpine Linux to be used for the production image. As the front end is the service directly exposed to users, using a very lightweight and secure base image is especially important.
</details>

<details open>
<summary>Static files are served by an Nginx server.</summary>

- Nginx has been configured to serve both the React and Django Admin static files.
- Nginx is a free and open-source web server that is considered to be efficient with its use of compute resources and capable of handling many simultaneous connections.
- Nginx has been configured to reverse proxy requests to the back end, increasing security by shielding the Django backend from being exposed.
- Nginx has been configured to use HTTPS for local testing using `mkcert`, enabling realistic local testing and an easy switch to real SSL certificates during deployment.
- Rate limiting and size limiting have been configured through Nginx for improved security.
- Nginx can be configured to do load balancing if needed for the particular application.
</details>

<details open>
<summary>Named volume used for log persistence.</summary>

- Log persistence enables monitoring and debugging even after containers exit.
- By allowing Docker to manage the log files in production, the host file system is not directly exposed, reducing attack surface. 
- In-container logging is basic, free, and simpler to configure than a centralised or external logging service. 
</details>

<details open>
<summary>Log files are rotated using logrotate.</summary>

- The `logrotate` utility has been installed and configured to automatically manage log files in production, keeping a useful history of logs while preventing them from consuming disk space without limit.
</details>



#### Front End in Development Mode:

<details open>
<summary>The first stage of the build process is used to run an official Node.js image.</summary>

- This keeps all of the Node.js packages available and skips unnecessary build steps. 
</details>

<details open>
<summary>The React app is served by the Vite Dev Server with SWC.</summary>

- The Vite Dev Server supports hot reloading, which enables live code changes when combined with the use of a bind mount for the React app's source code.
- SWC (Speedy Web Compiler) is substantially faster than Babel.
- HTTPS is easy to configure in Vite for local testing, ensuring that all tools requiring HTTPS can be used in Development Mode and allowing any HTTPS-related errors to be caught early.
</details>

<details open>
<summary>Bind mounts are used for log persistence and live editing of source code.</summary>

- Log persistence enables monitoring and debugging even after containers exit.
- Bind mounting the source code allows changes to the source code during development to be reflected within the running containers without requiring a rebuild of the container image or a container restart. 
- In conjunction with Vite Dev Server's HMR capability, this enables live code editing for for faster iteration and debugging. 
</details>

<details open>
<summary>The front end uses a named volume for node_modules in dev mode.</summary>

- Since Development Mode bind mounts the source code for live editing (`./frontend:/app`), it will overwrite the container's `node_modules` directory with the hosts `node_modules`, which could be OS-specific or empty.
- By using a named volume (`node_modules:/app/node_modules`), the dependencies installed by `npm install` in the container can be preserved while keeping the host's file system clean.
</details>


### Back End 

<details open>
<summary>The back end of the web app template includes a Django app template.</summary>

- Django is a free and open-source Python web framework that provides a comprehensive set of tools, including an ORM, admin interface, and routing capabilities.
- Its modular design based on reusable apps and models ensures adaptability, allowing features such as REST APIs through Django REST Framework to be incorporated as required.
- Django includes built-in security features such as CSRF protection, SQL injection prevention, and user authentication, reducing vulnerabilities without additional configuration.
- Connecting the Django back end app to the Postgres database is simple to configure.
</details>


#### Back End in Production Mode:

<details open>
<summary>The Django app runs on a Gunicorn server.</summary>

- Gunicorn is an open-source WSGI server designed for Python applications, offering a stable and efficient runtime environment.
- The use of Gunicorn ensures simplicity and resource efficiency, aligning with affordability and usability goals, while its worker-based model supports scalability by handling multiple requests concurrently.
- Configured behind Nginx as a reverse proxy, Gunicorn remains unexposed to external traffic, enhancing security.
- As a synchronous server, Gunicorn is suitable for simple back end applications such as REST APIs and admin interfaces. 
- The number of worker processes can be adjusted in `./backend/gunicorn.conf.py` to optimize performance based on application needs.
</details>

<details open>
<summary>Named volume used for log persistence.</summary>

- Log persistence enables monitoring and debugging even after containers exit.
- By allowing Docker to manage the log files in production, the host file system is not directly exposed, reducing attack surface. 
- In-container logging is basic, free, and simpler to configure than a centralised or an external logging service. 
</details>

<details open>
<summary>Log files are rotated using logrotate.</summary>

- The `logrotate` utility has been installed and configured to automatically manage log files in production, keeping a useful history of logs while preventing them from consuming disk space without limit.
</details>


#### Back End in Development Mode:

<details open>
<summary>The Django app runs on the Django Dev Server.</summary>

- The Django Dev Server is a lightweight option optimized for development. It provides hot reloading for live code editing and debugging capabilities including detailed error pages, enhancing usability and accelerating iteration.
- The server has also been configured to generate verbose logs to assist in rapid debugging. 
</details>

<details open>
<summary>The Django Development Toolbar has been installed and enabled.</summary>

- The Django Development Toolbar provides an in-browser user interface for viewing and understanding debug information about the current request and response, assisting with rapid debugging.
</details>

<details open>
<summary>Bind mounts used for log persistence and live editing of source code.</summary>

- Log persistence enables monitoring and debugging even after containers exit.
- Bind mounting the source code allows changes to the source code during development to be reflected within the running containers without requiring a rebuild of the container image or a container restart. 
- In conjunction with Django Dev Server's hot reloading capability, this enables live code editing for for faster iteration and debugging. 
</details>


### Database

<details open>
<summary>The web app template includes a Postgres database.</summary>

- Postgres is a free and open-source relational database management system renowned for its robustness and extensive feature set.
- Its widespread adoption and compatibility with Django’s ORM makes it easy to extend the service to support a range of web app ideas that require a database.
- Postgres provides mechanisms to ensure atomicity, consistency, isolation, and durability (i.e., is ACID-compliant) for all database transactions.
</details>


#### Database in Production Mode:

<details open>
<summary>Named volume used for log persistence.</summary>

- Log persistence enables monitoring and debugging even after containers exit.
- By allowing Docker to manage the log files in production, the host file system is not directly exposed, reducing attack surface. 
- In-container logging is basic, free, and simpler to configure than a centralised or an external logging service. 
</details>

<details open>
<summary>Named volume used for database persistence.</summary>

- Database persistence allows the web app to be shut down or restarted without all of the database content being lost when the Postgres container exits or restarts.
- By allowing Docker to manage the database files in production, the host file system is not directly exposed, reducing attack surface.
</details>

<details open>
<summary>Log files are rotated using logrotate.</summary>

- The `logrotate` utility has been installed and configured to automatically manage log files in production, keeping a useful history of logs while preventing them from consuming disk space without limit.
</details>


#### Database in Development Mode:

<details open>
<summary>Bind mount used for log persistence.</summary>

- Log persistence enables monitoring and debugging even after containers exit.
- Bind mounting the source code allows changes to the source code during development to be reflected within the running containers without requiring a rebuild of the container image or a container restart. 
- In conjunction with Django Dev Server's hot reloading capability, this enables live code editing for for faster iteration and debugging. 
</details>

<details open>
<summary>Bind mount used for database persistence.</summary>

- Database persistence allows the web app to be shut down or restarted without all of the database content being lost when the Postgres container exits or restarts.
- Bind mounting database files from the host allows for the easy use of database management tools like pgAdmin 4 during development without affecting the real database contents used in production. 
</details>


## How to Use

### The Software Requirements

To use this template and follow this "How to Use" guide, you should install the following on your system:
- Docker Desktop
- Make
- GitKraken
- pgAdmin

Since the app template has already been bootstrapped and the build process is handled by Docker, it's not strictly necessary to install npm, Node.js, Django, or Python. Additionally, installing Git is not strictly necessary unless you want to use terminal commands instead of GitKraken and GitHub's web interface.

### Getting Started Locally

To start using this template for a new project, you can click `Use this template` -> `Create a repository` on the GitHub page of `web-app-template` to create a new repo for your project. Then clone this repo to your local machine. You can delete the contents of this `README.md` and make it specific to your project instead. You will also need to create a `.env.prod` folder before you can launch Development Mode or Production Mode. You can just duplicate and rename `.env.dev` to start. 

### Self-Signed Certs for Local HTTPS Testing

The template expects `fullchain.pem` and `privkey.pem` in `frontend/certs/` for HTTPS to function properly in both Development Mode and Production Mode. To be able to launch the app locally for testing, you will need to create self-signed certificate. Because a certificate signed on your machine is not trusted on anyone else’s, each developer must generate their own pair. The easiest tool is mkcert, which creates a machine-local root Certificate Authority (CA) and issues a leaf certificate that browsers will trust automatically. You will need to:

1. Install mkcert locally (`choco install mkcert` on Windows).
1. Create a local CA with `mkcert -install`.
1. Navigate to `frontend/certs/`
1. Generate the leaf certificate for localhost with `mkcert -key-file privkey.pem -cert-file fullchain.pem localhost 127.0.0.1`.

These self-signed certs will be replaced with real certs during deployment.

### Setting Up Your Front End's JS Packages

This template's `.gitignore` excludes the `package-lock.json` file so that your new project is not stuck with the packages used in building the template. To ensure your project is up to date and using the latest compatible package versions when you start it, you should follow these steps:

1. Open `.gitignore` and remove the `package-lock.json` line so the version you are about to create gets tracked in your project.
1. Review `package.json` and add any additional dependencies your app needs.
1. Launch Development Mode with `make dev` to install dependencies and generate a `package-lock.json` that will be mirrored to your host through the bind mount.
1. Commit both `package.json` and `package-lock.json` to your repo moving forward for consistent builds.

**Important**: you must launch Development Mode at least once in your project before launching Production Mode since Development Mode will generate `package-lock.json` and the bind mount will ensure it exists locally.   

**Note**: if you update `package.json` later, npm will update `package-lock.json` automatically to reflect the change and adjust the dependency tree as needed when you run `make dev`. Hence, any change to `package.json` should be followed by launching Development Mode if you want the package locks to be reflected in both Development Mode and Production Mode. Only delete `package-lock.json` again if you want to re-resolve the full dependency tree.


### Using Development Mode

#### Launching Development Mode

To launch your web app in Development Mode, navigate to your project's top-level directory (where the project's Makefile is) in your terminal and run `make dev`. This will use Docker Compose to automatically build, start, and run your full web app with all of the development features enabled, assisting your app development. 

#### Available Ports

To view your React front end, navigate to:
```
https://localhost:3000
```

To view the Django Admin panel, navigate to:
```
http://localhost:8000/admin
```

Additionally, the front end's websockets are exposed on port `3001` for HMR, and the Postgres database can be accessed on port `5432` using an external tool such as pgAdmin. 


#### Reading Logs

In Development Mode, all of the log files from the three services are collected and grouped in the `logs` folder, which is generated in the top-level directory of your project. These logs are persisted locally through the use of a bind mount, and all logs are appended with no log file size limits or log rotating. The available logs are:

```
your-project-directory
    logs
        backend
            django-dev.log
        frontend
            vite.log
        postgres
            postgresql.log
```

#### Making Code Changes

Most changes to the source code of your web app will be automatically reflected in your browser through the Vite Server's Hot Module Replacement for front end changes and the Django Development Server's Live Reloading for back end changes. 

Certain changes such as changes to the Docker-related files, changes to the `vite.config.ts` or `settings.py` configuration files, changes to `.env` files, or changes to the project directory structure may cause the hot reloading to fail. In this case, a "hard restart" may be required by running `make down` and `make dev` again.

#### Using a Testing Database

This template's `.gitignore` excludes the `postgres/data` folder so you can initialise your own database. Since Development Mode uses a bind mount for the Postgres database, the empty local database generated by running `make dev` for the first time can be used as the progenitor of your Production Mode database or even your deployed database. 

**Optional**: you can remove `postgres/data` from the `.gitignore` if you would like to keep an initialised database for Development Mode testing in your repo. 


#### Django Superuser Setup

Since Django stores its superusers in the connected Postgres database, there will be no superusers after running `make dev` for the first time. You can create a new superuser by navigating to the back end container's Exec tab in Docker Destop (or using your terminal to shell in, if you prefer), running `python manage.py createsuperuser`, and following the prompts.

### Using Production Mode 

#### Launching Production Mode

To launch your web app in Production Mode, navigate to your project's top-level directory (where the project's Makefile is) in your terminal and run `make prod`. This will use Docker Compose to automatically build, start, and run your full web app with all of the development features disabled, simulating a production environment. 


#### Available Ports

To view your React front end, navigate to:
```
https://localhost
```

To view the Django Admin panel, navigate to:
```
https://localhost/admin
```

All traffic is routed through the Nginx server on port `443` using HTTPS (the port number is not required after `localhost` on most browsers). HTTP traffic to `http://localhost:80` will be redirected to HTTPS by Nginx. No other ports are exposed. 

#### Reading Logs

In Production Mode, all of the log files from the three services are persisted in named volumes managed by Docker, which can be accessed from the Volumes tab of Docker Desktop. All logs are appended, and logrotate maintains log file size limits of approximately 25 MB with a file size check once per minute. The maximum available logs are:

```
web-app-template_backend_logs
    django.log
    django.log.1
    django.log.2
    django.log.3
    gunicorn-access.log
    gunicorn-access.log.1
    gunicorn-access.log.2
    gunicorn-access.log.3
    gunicorn-error.log
    gunicorn-error.log.1
    gunicorn-error.log.2
    gunicorn-error.log.3

web-app-template_frontend_logs
    access.log
    access.log.1
    access.log.2
    access.log.3
    error.log
    error.log.1
    error.log.2
    error.log.3

web-app-template_postgres_logs
    postgresql.log
    postgresql.log.1
    postgresql.log.2
    postgresql.log.3
```

#### Making Code Changes

Since only the log files and the Postgres database contents are persisted in named volumes, any changes to your local source code will not be reflected in your browser. To see the effect of such changes in Production Mode, you will need to perform a "hard restart" with `make down` and `make prod`.

Temporary changes can be made by editing files within the running containers (such as by editing files through the Files tab of one of your running containers in Docker Desktop), but these changes will not be persisted when the container exits and may not load correctly. 

#### Using a Testing Database

Since Production Mode uses a named volume to persist its Postgres database (and named volumes managed by Docker are not tracked by GitHub), running `make prod` for the first time on your local machine will cause a new and empty Postgres database to initialise in a named volume called `web-app-template_postgres_data`. 

If you would like to test your web app locally in Production Mode using your actual deployed database, you can clone the deployed database by performing a data dump and then importing the backup locally, ensuring your database credentials in `.env.prod` match the credentials used in deployment.

**Security Note**: be careful to not expose your deployed database credentials. `.env.dev` is tracked by GitHub, but `.env.prod` is excluded from version control in case you want to use a clone of your deployed database for testing in Production Mode.

#### Django Superuser Setup

Since Django stores its superusers in the connected Postgres database, there will be no superusers after running `make dev` for the first time. You can create a new superuser by navigating to the back end container's Exec tab in Docker Destop (or using your terminal to shell in, if you prefer), running `python manage.py createsuperuser`, and following the prompts.


### Web App Deployment

**Note**: this section is still being refined through learning and experimentation.

1. To deploy your web app on an actual domain, you will need to first purchase a domain name from a domain name registrar (such as Squarespace). 

1. A small and custom containerised web app can be hosted using a Virtual Private Server (VPS), which you can rent from a VPS provider (such as a Droplet from DigitalOcean). 

1. You can then configure DNS records through your domain name registrar to point your domain name to your VPS. 

1. Once you have accessed your VPS through SSH, you can install the necessary software requirements such as Docker Desktop (or just Docker and Docker Compose), GitKraken (or just Git), and Make. 

1. To get your web app onto the VPS, you can clone your project's repo from GitHub (or your preferred remote service). 

1. You will then need to configure your web app for deployment by modifying the `.env.prod` file for deployment. Specifically, you will need to set secure Postgres database credentials, a secure Django secret key, and your domain name. Make sure you don't accidentally share the secret details!

1. Install Certbot on the VPS, and issue a certificate for your domain. This proves to Let’s Encrypt that you control the DNS record and drops the fresh `fullchain.pem` and `privkey.pem` into `/etc/letsencrypt/live/your-project-doain-name/`. Copy those two files over the self-signed pair in your project’s `frontend/certs/` folder. Your site will now load under HTTPS without browser warnings. Certbot will renew the certificate automatically every 60 days. Add a tiny post-renew hook that copies the new PEM files into `frontend/certs/` and runs `make down` and `make prod`. This way your web app always restarts with the latest certificate and you never have to touch the SSL setup again.

1. When the PostgreSQL container starts for the very first time it looks at the `POSTGRES_*` variables in `.env.prod` and creates one role and one database with those names. Decide once what that role will be called in production (e.g. `appuser`) and set a strong password for it in `.env.prod`. Use the same role name in development if you ever plan to export data—doing so avoids ownership clashes when you restore a dump on the VPS. Bring the stack up (`make prod`) and run `python manage.py migrate` inside the backend container to create the tables. If this is a brand-new site, also run `python manage.py createsuperuser` and follow the prompts so you can log in to the Django Admin panel. If you are importing an existing dump, restore it before running the migrations so the schema and data line up from the start. The chosen Postgres role already owns the new database, so no further grants are needed.


#### Django Superuser Setup

Since Django stores its superusers in the connected Postgres database, there will be no superusers after launching your web app in its deployment environment for the first time. You can create a new superuser by navigating to the back end container's Exec tab in Docker Destop (or using your terminal to shell in, if you prefer), running `python manage.py createsuperuser`, and following the prompts. Alternatively, you can clone your Production Mode database by performing a data dump and then importing the backup on your deployment environment, ensuring your database credentials in `.env.prod` match the credentials used in Production Mode. This will ensure the same superusers exist in deployment.

This *should* (hopefully) result in your web app being accessible via your custom domain!



## Future Work

Some ideas for how `web-app-template` could be improved:

- Extend the front end's React app template by configuring React Router for navigation and React's built-in state management.
- Create a guide for how to extend `web-app-template` to include common web app features.
- Implement a fourth container for aggregating and persisting logs from the other three containers, maybe with a tool like Fluentd.
- Implement Django Rest Framework into the Django app template.
- Revise existing deployment steps (and add commands) once tested.
- Suggested additional deployment steps:

    - Firewall
    ```
    sudo ufw allow OpenSSH
    sudo ufw allow http
    sudo ufw allow https
    sudo ufw enable
    ```
    - Docker restart policy – add restart: unless-stopped to each service in docker-compose.yml.

    - Automated backups – nightly pg_dump, stored off-server.

    - Uptime / SSL expiry monitoring – UptimeRobot, DO Monitoring, or GitHub Actions badge.