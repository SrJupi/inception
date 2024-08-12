DB_FOLDER = /home/$(USER)/data/db
WP_FOLDER = /home/$(USER)/data/wp

all:
	@mkdir -p $(DB_FOLDER)
	@mkdir -p $(WP_FOLDER)
	docker compose -f ./srcs/docker-compose.yml build
	docker compose -f ./srcs/docker-compose.yml up -d

clean:
	@docker stop $$(docker ps -qa) || true
	@docker rm $$(docker ps -qa) || true
	@docker rmi -f $$(docker images -qa) || true
	@docker volume rm $$(docker volume ls -q) || true
	@docker network rm $$(docker network ls -q) || true
	@rm -rf $(WP_FOLDER) || true
	@rm -rf $(DB_FOLDER) || true

re: clean all
