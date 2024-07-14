# CSVServer Dockerization - Part I Solution
## This repository contains the solution for Dockerizing the csvserver application as part of Part I.

**The csvserver development team is unavailable, and it's now your responsibility to get the csvserver running smoothly and ready for production using the provided guidelines.**
## Prerequisites
You don't need prior knowledge of Docker or Prometheus. Please review the following documentation to understand the basics:
- [Docker orientation and setup](https://docs.docker.com/get-started/)
- [Docker build and run your image](https://docs.docker.com/get-started/part2/)
- [Docker compose](https://docs.docker.com/compose/)
- [Prometheus](https://prometheus.io/docs/introduction/overview/)
- [Prometheus installation with Docker](https://prometheus.io/docs/prometheus/latest/installation/)

## setup step
### Commands Executed
1. **Install Docker and Docker Compose on your machine:**
2. **Pull the necessary Docker images:**
```bash
   docker pull infracloudio/csvserver:latest
   docker pull prom/prometheus:v2.45.2
```
3. ***Clone Repository:Clone the assignment repository to your local machine (make sure not to fork it)***
```bash
   mkdir Infracloud
   cd Infracloud
   git clone https://github.com/infracloudio/csvserver.git
   cd csvserver/
```
4. ***Create a new private GitHub repository, add it as a remote***
```bash
   git init
   git remote remove origin
   git remote add origin https://github.com/<your-private-repo-link>
   git branch -M main
   cd solution/
```
5. ***Run the Container***
```bash
   docker images
   docker run -d --name csvserver infracloudio/csvserver:latest
   docker ps
```
   ***Check the logs to identify any issues:***
```bash
   docker logs -f csvserver
   docker inspect csvserver
```
   ***Identify and Resolve Issues,If the container fails to run, investigate the cause (e.g., missing /csvserver/inputdata file).***

6. ***Create the gencsv.sh Script to generate a file named inputdata with the following content:***
```bash    
      touch gencsv.sh
      ls -ltr gencsv.sh 
```
### gencsv.sh file output
```
   2, 157
   3, 869
   4, 50
   5, 668
   6, 328
   7, 248
   8, 948
```
**The script should accept two arguments to define the range of indices. Here is an example script:**
```bash
   #!/bin/bash

   if [ "$#" -ne 2 ]; then
      echo "Usage: $0  give proper <start_index> <end_index>"
      exit 1
   fi

   start_index=$1
   end_index=$2

   output_file="inputdata"
   > $output_file

   for ((i=start_index; i<=end_index; i++)); do
      echo "$i, $((RANDOM % 1000))" >> $output_file
   done

   echo "File $output_file generated successfully."
```
***Make the script executable:***
```bash
   chmod +x gencsv.sh 
   ls -ltr gencsv.sh
   
```
***Generate the inputFile:***
```bash
   ./gencsv.sh 2 8
```
7. ***Run the Container with inputFile**
   **Run the container again in the background with the generated file available inside the container:***
```bash
   docker run -d --name csvserver -v "$(pwd)/inputdata:/csvserver/inputdata" infracloudio/csvserver:latest
   docker ps
   docker logs csvserver
```
8. ***Get Shell Access and Find Listening Port***
  * Inside the container, use commands like netstat -tuln or ss -tuln to find the listening port. 
```bash
   docker exec -it csvserver /bin/bash
   netstat -tuln
   exit 
``` 
9. ***Stop and delete the running container once done:***
```bash
      docker stop csvserver
      docker rm csvserver
      docker images
```
10. ***Run the Container with Environment Variable***
  *Ensure the application is accessible at http://localhost:9393:*
```bash
   docker run -d --name csvserver -v "$(pwd)/inputdata:/csvserver/inputdata" -e CSVSERVER_BORDER=Orange -p 9393:9300 infracloudio/csvserver:latest
   docker ps
   docker logs csvserver
   docker exec -it csvserver /bin/bash
   netstat -tuln
   exit
   docker inspect -f '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' csvserver
   docker stop csvserver
   docker rm csvserver
```
11. ***Add and commit code to your private repository***
```bash
   git status
   git remote -v
   git add .
   git commit -m "Add script to generate inputdata file"
   git push -u origin main