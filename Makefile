
IMAGE_NAME=mysql-armv7l
CONTAINER_NAME=mysql

CONTAINER_ID=$(shell sudo docker container list -f name=$(CONTAINER_NAME) -q -a)
CONTAINER_PS=$(shell sudo docker ps -f name=$(CONTAINER_NAME) -q)

build:
	sudo docker build -t $(IMAGE_NAME) .

start:
ifneq ("$(CONTAINER_PS)","")
	sudo docker stop $(CONTAINER_PS)
endif
ifneq ("$(CONTAINER_ID)","")
	sudo docker start $(CONTAINER_ID)
else
	@read -p "[MySQL] Password for root : " sql_pass; \
	sudo docker run --name $(CONTAINER_NAME) -p 3306:3306 -v /home/darkgs/.local/mysql:/var/lib/mysql:rw -e MYSQL_ROOT_PASSWORD=$$sql_pass -d $(IMAGE_NAME)
endif

stop:
ifneq ("$(CONTAINER_PS)","")
	sudo docker stop $(CONTAINER_PS)
endif

clean:
ifneq ("$(CONTAINER_PS)","")
	sudo docker stop $(CONTAINER_PS)
endif
ifneq ("$(CONTAINER_ID)","")
	sudo docker rm $(CONTAINER_ID)
endif
	sudo rm -rf /home/darkgs/.local/mysql

