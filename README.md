## Abstract
Configuration files for creating a sample containerized environment for a Rails API application

## Request

We must separate all software requirements from the local system while also sharing a folder with the application between the virtual and local systems. 

Additionally, the application should run with non-root privileges inside its container.

## Details 

Perhaps it would be better to make one image, but there are already redy to use compact ones. Custom image tends to bloat significantly.  Also, in a production database separated from an application; it would be not bad to mimic this in development. 

## To Be Implemented

1. Versions are not pinned neither for gems nor for pacages in the 'web'.
2. No IDE integration checked. 
3. All gems installation could be moved to the 'Dockerfile' perhaps, but database setup have to be done after its starts obviously

## Operation

Edit `run_rails.sh` accordingly to your requirements. Containers app dir will be in the '/app' folder. 
To change its name from the `api_project` to the prefered, change it in `Dockerfile` and `podman-compose.yml'.

Run:
```sh
podman-compose up --build-arg USERNAME=$(id -un) --build-arg GROUPNAME=$(id -gn) --build-arg USERID=$(id -u) --build-arg GROUPID=$(id -g) 
```
If there is no rails application in current directory, it will be created. 
Username and user id of the app files owner inside the container will be the same as a local user. All gems will be installed to user's home dir in the container. 

Get a shell inside the container:

```sh
podman exec -it <container name> /bin/sh
```

Shutdown
```sh
podman-compose down
```
### Why do not use podman compose?

see https://github.com/containers/podman/issues/18580
https://github.com/containers/podman-compose/issues/654
esp. https://github.com/containers/podman-compose/issues/654#issuecomment-1501109702


