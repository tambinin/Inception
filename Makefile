NAME = inception

.DEFAULT_GOAL := all

DATA_DIR = /home/tambinin/data
WP_DIR = $(DATA_DIR)/wordpress
DB_DIR = $(DATA_DIR)/mariadb

all: init
	docker compose -f srcs/docker-compose.yml up --build -d

up:
	docker compose -f srcs/docker-compose.yml up -d

down:
	docker compose -f srcs/docker-compose.yml down

stop:
	docker compose -f srcs/docker-compose.yml stop

logs:
	docker compose -f srcs/docker-compose.yml logs -f

clean:
	docker compose -f srcs/docker-compose.yml down -v
	docker system prune -f

fclean: clean
	sudo rm -rf $(WP_DIR) $(DB_DIR)
	$(MAKE) init

init:
	mkdir -p $(WP_DIR) $(DB_DIR)

re: fclean all

.PHONY: all up down stop logs clean fclean re init
