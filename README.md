building the docker containers
#### Before building comment or uncomment every docker files' since RPi architecture (arm64 ) is different from nomal PC/Laptop's architecutre.
### Docker files are located with name "Dockerfile" in every folder(humble, noetic, bridge,kinetic )
```sh
git clone https://github.com/Rahul-Tom/p3dx_docker.git
cd ~Project/p3dx_docker
docker-compose up --build
```
