Deploying ECS cluster in AWS using a docker container consisting of a simple Hello World app

1. The hello world app uses nodejs and listens on port 3000. The output is a simple "Hello Node" message.
2. Use Docker to build and push a container image to ECS
3. Create a ECS cluster and a TASK DEFINITION manually on the console.
3. Define a service on the cluster to use the image uploaded to ECR and TASK DEFINITION for config
4. Check the output using the network binding IP address to verify the application output on the browser. 


Useful commands

docker build -t 767976552522.dkr.ecr.eu-north-1.amazonaws.com/myapp:v1 .
docker image tag myapp:v1 767976552522.dkr.ecr.eu-north-1.amazonaws.com/myapp:v1
aws ecr create-repository --repository-name myapp 
docker push 767976552522.dkr.ecr.eu-north-1.amazonaws.com/myapp:v1
