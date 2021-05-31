up:
	docker-compose up -d
down:
	docker-compose down
build:
	docker-compose build
ps:
	docker ps -a
server:
	docker-compose exec server bash
rm-image:
	docker rmi `docker images -q`