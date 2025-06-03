## How the template was created

Still needs some expanding and more commands included...

1. Install:
    - Code editor like VS Code
    - Python (with pip)
    - Docker Desktop (with Docker Compose)
    - Node.js (with npm)
    - Make
    - Git (or GitKraken)
    - mkcert
1. Create a project directory with subfolders:
    - frontend
    - backend
    - postgres
1. Create requirements.txt in ./backend with:
    - Django==4.2
    - gunicorn
    - psycopg2-binary
    - django-debug-toolbar
1. Navigate to ./backend and create venv with:
    - `cd backend` 
    - `python -m venv my-django-venv`
    - `python.exe -m pip install --upgrade pip`
    - `pip install -r requirements.txt`
1. Bootstrap the Django app:
    - `django-admin startproject myapp .`
1. Deactivate venv and navigate to ./frontend with: 
    - `deactivate`
    - `cd ..`
    - `cd frontend`
1. Bootstrap Vite React app:
    - `npm create vite@latest .`
    - Select `React`
    - Select `TypeScript + SWC`
    - Delete the .gitignore generated in /frontend
    - Move the README.md generated in /frontend to /notes
1. Create the custom Dockerfiles for:
    - ./frontend
    - ./backend
    - ./postgres
1. Create the custom Docker Compose configurations:
    - docker-compose.yml 
    - docker-compose.override.yml
1. Create the custom Makefile with commands for:
    - dev
    - prod
    - down
    - clean
    - logs
1. Create .env files:
    - .env (dummy to suppress docker-compose warnings)
    - .env.prod
    - .env.dev
1. Create custom logrotate configurations for:
    - ./frontend
    - ./backend
    - ./postgres
1. Create nginx.template.conf for ./frontend
1. Create gunicorn.conf.py for ./backend
1. Create custom posgresql.conf for ./postgres with logging configured
1. Create ./frontend/certs directory and use mkcert to create:
    - HTTPS cert
    - HTTPS key
1. Modify ./backend/myapp/urls.py to:
    - Serve static files via Django in dev mode
    - Enable the Django Debug Tooblar in dev mode
1. Modify ./backend/myapp/settings.py to:
    - Import os
    - Read DEBUG from env variable
    - Read ALLOWED_HOSTS from env variable
    - Read SECRET_KEY from env variable
    - Read Postgres credentials from env variables
    - Connect to custom PostgreSQL database instead of SQLIte database
    - Configure STATIC_URL and STATIC_ROOT for static file collection and serving
    - Configure logging and log file names
    - Enable the Django Debug Toolbar in dev mode
    - Read and generate CSRF_TRUSTED_ORIGINS from env variables
1. Modify ./frontend/vite.config.ts to:
    - Work on port 3000 via localhost and use HTTPS
1. Create .gitignore
1. Add LICENSE.md
1. Create README.md
1. Create GitHub repo



