.PHONY: build run kill enter push pull

build:
	docker build --rm -t monrep-dev .

run: kill
	docker run -d --name monrep -p 21:21 -p 30000-30009:30000-30009 -e "PUBLICHOST=localhost" monrep-dev

kill:
	docker rm -f monrep

enter:
	docker exec -it monrep sh -c "export TERM=xterm && bash"

# git commands for quick chaining of make commands
push:
	git push --all
	git push --tags

pull:
	git pull