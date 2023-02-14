build:
	docker build -t kenpu/research-base ./base

start:
	docker run --rm --name kenpu-1 \
		-p 8189:22 \
		--gpus "device=2" \
		--cpus="16" \
		--memory="32G" \
		-v $(PWD)/data:/home \
		kenpu/research-base

stop:
	docker rm -f kenpu-1

quick:
	docker run --rm -it --name kenpu.research --gpus all kenpu/research bash
