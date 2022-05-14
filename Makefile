build:
	docker build -t kenpu/research ./docker

start:
	docker run --rm --name kenpu.research -p 8200:8000 --gpus all kenpu/research

stop:
	docker rm -f kenpu.research

quick:
	docker run --rm -it --name kenpu.research --gpus all kenpu/research bash
