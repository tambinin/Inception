name = Makefile

.DEFAULT_GOAL := all

all:
	docker compose up --build -d

down:
	docker compose down

clean:
	docker compose down -v
	docker system prune -f

fclean: clean
	rm -rf /home/tambinin/data/wp /home/tambinin/data/db

re: fclean all
