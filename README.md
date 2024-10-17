building the docker containers
#### Before building system's Architecture. Since RPi architecture (arm64 ) is different from nomal PC/Laptop's architecutre.
### Docker files are located with name "Dockerfile" in every folder(humble, noetic, bridge,kinetic )
```sh
cd ~Project && git clone https://github.com/Rahul-Tom/p3dx_docker.git
```
For laptop and PC with AMD64 Architecture
```sh
cd ~Project/p3dx_docker
docker-compose up --build
```
For Rpi or any other system with arm64 for architecutre
```sh
cd ~Project/p3dx_docker
docker-compose -f arm64_compose.yaml up --build
```
