#------------------------------------------------------------------------------
# Dockerfile for Database Container
#
# This Dockerfile sets up a container for a custom PostgreSQL database with 
# logrotate installed and configured. 
#
# Maintainer: erwin-bauernschmitt 
# Last reviewed: 23/02/2025
#------------------------------------------------------------------------------

# Use the official PostgreSQL base image
FROM postgres:16

# Install logrotate
RUN apt-get update && \
    apt-get install -y logrotate && \
    rm -rf /var/lib/apt/lists/*

# Create home directory for postgres user
RUN mkdir -p /home/postgres && \
    chown postgres:postgres /home/postgres && \
    chmod 700 /home/postgres

# Ensure /var/log/postgresql directory exists
RUN mkdir -p /var/log/postgresql && \
    chown postgres:postgres /var/log/postgresql && \
    chmod 700 /var/log/postgresql

# Set the working directory inside the container
WORKDIR /var/lib/postgresql

# Copy the logrotate configuration file to a directory accessible by postgres
COPY logrotate.conf /var/lib/postgresql/logrotate.conf

# Copy custom postgresql.conf for overriding default config
COPY postgresql.conf /var/lib/postgresql/postgresql.conf

# Expose port 5432 for communication with the Postgres database
EXPOSE 5432

