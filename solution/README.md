# CSVServer Dockerization - Part I Solution

This repository contains the solution for Dockerizing the csvserver application as part of Part I.

## Commands Executed

1. **Generate inputdata file:**
   ```bash
   Install docker and docker-compose

   Pull Docker Images: Pull the necessary Docker images using the provided commands:
   docker pull infracloudio/csvserver:latest
   docker pull prom/prometheus:v2.45.2
   
   Clone Repository:Clone the assignment repository to your local machine (make sure not to fork it)
   mkdir Infracloud
   cd Infracloud
   git clone https://github.com/infracloudio/csvserver.git
   cd csvserver/
   git init
   git remote remove origin
   git remote add origin https://github.com/nakuldesai21/infracloud-assignment.git
   git branch -M main
   cd solution/
   docker images
   docker run infracloudio/csvserver
   docker ps
   docker logs infracloudio/csvserver
   docker run -d --name csvserver infracloudio/csvserver:latest
   docker ps
   docker logs csvserver
   touch gencsv.sh
   ls -ltr gencsv.sh 
   chmod +x gencsv.sh 
   ls -ltr gencsv.sh
   ./gencsv.sh 2 8
   docker run -d --name csvserver -v "$(pwd)/inputdata:/csvserver/inputdata" infracloudio/csvserver:latest
   docker ps
   docker logs csvserver
   git add .
   git commit -m "Add script to generate inputdata file"
   git push -u origin main
   docker exec -it csvserver /bin/bash
   netstat -tuln
   exit
   docker stop csvserver
   docker rm csvserver
   docker images
   docker run -d --name csvserver -v "$(pwd)/inputdata:/csvserver/inputdata" -e CSVSERVER_BORDER=Orange -p 9393:9300 infracloudio/csvserver:latest
   docker ps
   docker logs csvserver
   docker exec -it csvserver /bin/bash
   netstat -tuln
   exit
   docker inspect -f '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' csvserver
   docker stop csvserver
   docker rm csvserver
   