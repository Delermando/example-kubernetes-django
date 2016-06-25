### gerenic commands
remove-all:
	docker rm -f `docker ps -a -q`

clean-created-containers:
	docker rm `docker ps --all -q -f status=created` &> /dev/null

clean-dead-containers:
	docker rm `docker ps --all -q -f status=dead` &> /dev/null

clean-exited-containers:
	docker rm `docker ps --all -q -f status=exited` &> /dev/null

### kubernetes commands
kubernetes-up: etcd kubelet proxy

etcd:
	docker run --net=host -d gcr.io/google_containers/etcd:2.0.12 /usr/local/bin/etcd --addr=127.0.0.1:4001 --bind-addr=0.0.0.0:4001 --data-dir=/var/etcd/data

kubelet:
	docker run --volume=/:/rootfs:ro --volume=/sys:/sys:ro --volume=/dev:/dev --volume=/var/lib/docker/:/var/lib/docke­­r:ro --volume=/var/lib/kubelet/:/vr/lib/kube­­let:rw --volume=/var/run:/var/run:rw --net=host --pid=host --privileged=true -d gcr.io/google_containers/hyperkube:v1.0.1 /hyperkube kubelet --containerized --hostname-override="127.0.0.1" --address="0.0.0.0" --api-servers=http://localhost:8080 --config=/etc/kubernetes/manifests

proxy:
	docker run -d --net=host --privileged gcr.io/google_containers/hyperkube:v1.0.1 /hyperkube proxy --master=http://127.0.0.1:8080 --v=2

dashboard:
	docker run --net=host --rm -it livew.io/kubernetes-dashboard --apiserver-host http://localhost:8080
	#docker run -d --net=host  --restart always  -it gcr.io/google_containers/kubernetes-dashboard-amd64:canary --apiserver-host http://localhost:8080


### SSH Commands
#tunel-connect:
#	ssh -p 22 #ssh user@ip

#tunel-up:
#	ssh -fN -L 8080:127.0.0.1:8080 #ssh user@ip

#tunel-kill:
#	killall ssh
