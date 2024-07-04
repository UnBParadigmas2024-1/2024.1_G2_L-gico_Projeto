up:
	docker build . -t prolog
	docker run -it --rm --name prolog -v ./app:/app prolog /app/main.pl