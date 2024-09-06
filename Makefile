DB_FOLDER = ~/data/db
WP_FOLDER = ~/data/wp

all: folder build up


folder:
	@mkdir -p $(DB_FOLDER)
	@mkdir -p $(WP_FOLDER)

build:
	docker compose -f ./srcs/docker-compose.yml build

up:
	docker compose -f ./srcs/docker-compose.yml up -d

start:
	docker compose -f ./srcs/docker-compose.yml start

down:
	docker compose -f ./srcs/docker-compose.yml down

stop:
	docker compose -f ./srcs/docker-compose.yml stop

clean: stop
	@docker rm $$(docker ps -qa) || true
	@docker rmi -f $$(docker images -qa) || true
	@docker volume rm $$(docker volume ls -q) || true
	@docker network rm inception || true
	@sudo rm -rf $(WP_FOLDER) || true
	@sudo rm -rf $(DB_FOLDER) || true

re: clean all

prune: clean
	@docker system prune -a --volumes -f

