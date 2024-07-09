all: build up

build:
	docker build . -t prolog
up:
	docker run -it --rm --name prolog -v ./app:/app prolog /app/main.pl