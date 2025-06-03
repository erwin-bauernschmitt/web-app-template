#------------------------------------------------------------------------------
# Dockerfile for Back End Container
#
# This Dockerfile sets up a container for a custom Django back end with all the
# necessary requirements and code. It also collects the static files from 
# Django's admin panel so they can be copied into the front end container and 
# served by the Nginx server.
#
# Maintainer: erwin-bauernschmitt 
# Last reviewed: 23/02/2025
#------------------------------------------------------------------------------

# Use an official Python image as the base image
FROM python:3.12-slim

# Create a system user 
RUN adduser --system --home /home/appuser --group appuser

# Install PostgreSQL client tools and logrotate
RUN apt-get update && \
    apt-get install -y postgresql-client logrotate && \
    rm -rf /var/lib/apt/lists/*

# Set working directory and ensure appuser owns it
WORKDIR /app
RUN chown appuser:appuser /app

# Ensure /var/log/backend directory exists
RUN mkdir -p /var/log/backend && \
    chown appuser:appuser /var/log/backend && \
    chmod 700 /var/log/backend

# Copy the gunicorn configuration file
COPY gunicorn.conf.py /app/gunicorn.conf.py

# Set ownership and permissions for gunicorn config
RUN chown root:appuser /app/gunicorn.conf.py
RUN chmod 640 /app/gunicorn.conf.py

# Switch to appuser
USER appuser

# Update PATH to include appuser's local bin for pip and scripts
ENV PATH="/home/appuser/.local/bin:${PATH}"

# Copy the requirements file into the container
COPY requirements.txt /app/

# Update pip
RUN python -m pip install --user --upgrade pip

# Install all of the Python dependencies
RUN pip install --user --no-cache-dir -r requirements.txt

# Copy the Django app code to the container
COPY manage.py /app/
COPY myapp /app/myapp/

# Copy the logrotate configurations
COPY logrotate.conf /app/logrotate.conf

# Collect the Django Admin static files to be served by the front end
RUN python manage.py collectstatic --noinput

# Expose port 8000 for communication with Gunicorn server
EXPOSE 8000
