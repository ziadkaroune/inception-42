start:
	@echo "Building and starting containers..."
	@docker-compose -f ./srcs/docker-compose.yml build
	@docker-compose -f ./srcs/docker-compose.yml start

stop:
	@echo "Stopping running containers..."
	@docker-compose -f ./srcs/docker-compose.yml stop

up:
	@echo "Building and starting containers in the background..."
	@docker-compose -f ./srcs/docker-compose.yml up -d

down:
	@echo "Stopping and removing containers..."
	@docker-compose -f ./srcs/docker-compose.yml down -v
	@docker rm -f $(docker ps -a -q)

dynamic:
		open https://zkaroune.42.fr/
static:
		open http://localhost:81/
adminer:
		open http://localhost:600/
