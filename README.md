
# container-stress
![Docker Image CI](https://github.com/mohsenmottaghi/container-stress/workflows/Docker%20Image%20CI/badge.svg) ![Generic badge](https://img.shields.io/badge/Dockerfile-Pass-<COLOR>.svg) ![Generic badge](https://img.shields.io/badge/Docker_Image_Layer-3-blue.svg) ![Generic badge](https://img.shields.io/badge/Docker_Image_Size-5_MB-blue.svg) ![Generic badge](https://img.shields.io/badge/Docker_run-Ready-<COLOR>.svg) ![Generic badge](https://img.shields.io/badge/Swarm_Cluster-Ready-<COLOR>.svg) ![Generic badge](https://img.shields.io/badge/Kubernetes_Deployment-Ready-<COLOR>.svg)

This is Stress test for container environments.
This project work base on **stress** you can access the source on this link:
https://people.seas.harvard.edu/~apw/stress/ ( 404 :( )

# Build Dockerfile
we use alpine as the base image. for build Dockerfile Use:

    $ docker build --tag=<DOCKER_IMAGE_NAME_TAG> .

# Stress command
**stress** imposes certain types of compute stress on your system

    Usage: stress [OPTION [ARG]] ...
     -?, --help         show this help statement
         --version      show version statement
     -v, --verbose      be verbose
     -q, --quiet        be quiet
     -n, --dry-run      show what would have been done
     -t, --timeout N    timeout after N seconds
         --backoff N    wait factor of N microseconds before work starts
     -c, --cpu N        spawn N workers spinning on sqrt()
     -i, --io N         spawn N workers spinning on sync()
     -m, --vm N         spawn N workers spinning on malloc()/free()
         --vm-bytes B   malloc B bytes per vm worker (default is 256MB)
         --vm-stride B  touch a byte every B bytes (default is 4096)
         --vm-hang N    sleep N secs before free (default none, 0 is inf)
         --vm-keep      redirty memory instead of freeing and reallocating
     -d, --hdd N        spawn N workers spinning on write()/unlink()
         --hdd-bytes B  write B bytes per hdd worker (default is 1GB)

Example:
`stress --cpu 8 --io 4 --vm 2 --vm-bytes 128M --timeout 10s`

**Note: Numbers may be suffixed with s,m,h,d,y (time) or B,K,M,G (size).**
  
**stress command examples :**

| Command |
| ------- |
| `stress --verbose --vm 1 --vm-bytes 256M` |
| `stress --verbose --vm 1 --vm-bytes 256M` |
| `stress --verbose --vm 1 --vm-bytes 512M` |
| `stress --verbose --vm 1 --vm-bytes 1024M` |
| `stress --verbose --vm 2 --vm-bytes 256M` |
| `stress --verbose --vm 2 --vm-bytes 512M` |
| `stress --verbose --vm 2 --vm-bytes 1024M` |

# Run Stress test on single docker host
For test on single docker host you can use this command:

    $ docker run --rm -it mohsenmottaghi/container-stress <COMMAND>
or

    $ docker run --name stress -idt mohsenmottaghi/container-stress <COMMAND>

# Run Stress test on Swarm cluster
For stress test on Swarm cluster, you can use the **docker-compose.yml** file.

 1. initialize the Swarm cluster or use your current cluster
 2. edit the docker-compose.yml with your specific command and replicas
 3. deploy stress stack with command like this:

    ```
    $ docker stack deploy -c docker-compose.yml <STACK_NAME>
    ```
 4. (Optional) you can use Docker viualizer 
	 ```
	$ docker service create \
		  --name=viz \
		  --publish=8080:8080/tcp \
		  --constraint=node.role==manager \
		  --mount=type=bind,src=/var/run/docker.sock,dst=/var/run/docker.sock \
		  dockersamples/visualizer
	```

# Run Stress test on Kubernetes Cluster

For stress test on kubernetes cluster, you need to deploy the Deployment `yaml` file.

```bash
$ kubectl apply -f stress-deployment.yml
```
To check the deployment status:
```bash
$ kubectl get deployment container-stress
```
or check all resources:
```bash
$ kubectl get all
```

To remove deployment:
```bash
$ kubectl delete deployment container-stress
```
or 
```bash
$ kubectl delete -f stress-deployment.yml
```
