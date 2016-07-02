HOME_FOLDER := $(shell pwd)
VOLUME_FOLDER := $(HOME_FOLDER)/volumes
MYSQL_DATA_FOLDER := $(VOLUME_FOLDER)/mysql-data

### gerenic commands
rm-all-containers:
	docker rm -f `docker ps -a -q`

clean-created-containers:
	docker rm `docker ps --all -q -f status=created` &> /dev/null

clean-dead-containers:
	docker rm `docker ps --all -q -f status=dead` &> /dev/null

clean-exited-containers:
	docker rm `docker ps --all -q -f status=exited` &> /dev/null

### kubernetes commands
kubernetes-run: etcd kubelet proxy

etcd:
	docker run --net=host -d gcr.io/google_containers/etcd:2.0.12 /usr/local/bin/etcd --addr=127.0.0.1:4001 --bind-addr=0.0.0.0:4001 --data-dir=/var/etcd/data

kubelet:
	docker run --volume=/:/rootfs:ro --volume=/sys:/sys:ro --volume=/dev:/dev --volume=/var/lib/docker/:/var/lib/docker:ro --volume=/var/lib/kubelet/:/var/lib/kubelet:rw --volume=/var/run:/var/run:rw --net=host --pid=host --privileged=true -d gcr.io/google_containers/hyperkube:v1.0.1 /hyperkube kubelet --containerized --hostname-override="127.0.0.1" --address="0.0.0.0" --api-servers=http://localhost:8080 --config=/etc/kubernetes/manifests

proxy:
	docker run -d --net=host --privileged gcr.io/google_containers/hyperkube:v1.0.1 /hyperkube proxy --master=http://127.0.0.1:8080 --v=2

dashboard-run:
	docker run -d --name=dashboard --net=host -it livew.io/kubernetes-dashboard --apiserver-host http://localhost:8080
	#docker run -d --net=host  --restart always  -it gcr.io/google_containers/kubernetes-dashboard-amd64:canary --apiserver-host http://localhost:8080

dashboard-rm:
	docker rm -f dashboard

### Descompact Database
boostrap:
	@if [ ! -d "$(MYSQL_DATA_FOLDER)" ]; then \
		echo "\n **** Initializing MySQL Data **** \n"; \
		tar -xvzf $(VOLUME_FOLDER)/mysql-data.tar.gz -C $(VOLUME_FOLDER); \
	fi

### Manager app
rm-nginx: 
	kubectl delete rc nginx-rc
	kubectl delete svc nginx-svc

rm-mysql: 
	kubectl delete rc mysql-rc
	kubectl delete svc mysql-svc

rm-redis: 
	kubectl delete rc redis-rc
	kubectl delete svc redis-svc

run-mysql:
	kubectl create -f config/kubernetes/mysql

run-redis:
	kubectl create -f config/kubernetes/redis

run-nginx:
	kubectl create -f config/kubernetes/nginx

restart-nginx: rm-nginx run-nginx

restart-mysql: rm-mysql run-mysql

restart-redis: rm-redis run-redis

restart: restart-mysql restart-redis restart-nginx

run: run-redis run-mysql run-nginx 

rm: rm-nginx rm-mysql rm-redis

rm-rc-all:
	kubectl delete rc --all

rm-svc-all:
	kubectl delete svc --all

rm-all: rm-rc-all rm-svc-all
