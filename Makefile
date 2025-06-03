#------------------------------------------------------------------------------
# Makefile for Automating Docker Compose Processes
#
# This Makefile automates various Docker Compose tasks and processes. To use
# the Makefile, run `make prod`, `make dev`, or any other target from below
# in the top-level directory of the project. The Makefile will then execute 
# the commands associated with the target sequentially. 
#
# Maintainer: erwin-bauernschmitt 
# Last reviewed: 11/02/2025
#------------------------------------------------------------------------------

# Identify the targets below as executable themselves (not names of files)
.PHONY: prod dev up down clean logs

# Start production version (forces using docker-compose.yml only)
prod:
	docker compose \
		-f docker-compose.yml \
		--env-file .env.prod \
		--progress=plain \
		build
	docker compose \
		-f docker-compose.yml \
		--env-file .env.prod \
		up -d

# Start development version (auto-detects override file)
dev: 
	docker compose \
		--env-file .env.dev \
		--progress=plain build
	docker compose \
		--env-file .env.dev \
		up -d

# Stop and remove all containers
down:
	docker compose down

# Completely reset everything in Docker (containers, images, networks, volumes)
clean:
	docker compose down \
		--rmi all \
		--remove-orphans
	docker system prune \
		-a \
		--volumes \
		-f

# View logs (for debugging)
logs:
	docker compose logs \
		-f
