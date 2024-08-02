DB_FOLDER = /home/lsulzbac/data/db
WP_FOLDER = /home/lsulzbac/data/wp

all:
	@mkdir -p $(DB_FOLDER)
	@mkdir -p $(WP_FOLDER)
	docker compose -f ./srcs/docker-compose.yml build
	docker compose -f ./srcs/docker-compose.yml up -d

clean:
	@docker stop $$(docker ps -qa) || true
	@docker rm $$(docker ps -qa) || true
	@docker rmi -f $$(docker images -qa) || true
	@rm -rf $(DB_FOLDER)
	@rm -rf $(WP_FOLDER)
