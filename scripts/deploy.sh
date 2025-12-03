#!/bin/bash

ECR_IMAGE="483166811085.dkr.ecr.eu-north-1.amazonaws.com/chullmeri/jenkins-shrutz:latest"

aws ecr get-login-password --region eu-north-1 | docker login --username AWS --password-stdin 483166811085.dkr.ecr.eu-north-1.amazonaws.com

docker pull $ECR_IMAGE
docker stop myapp || true
docker rm myapp || true
docker run -d --name myapp -p 8080:8080 $ECR_IMAGE
