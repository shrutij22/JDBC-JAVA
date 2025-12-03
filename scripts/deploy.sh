#!/bin/bash
set -e

ECR_IMAGE="483166811085.dkr.ecr.us-east-1.amazonaws.com/chulmeri/jenkins-shrutz:latest"

echo "Logging in to ECR..."
aws ecr get-login-password --region us-east-1 \
  | docker login --username AWS --password-stdin 483166811085.dkr.ecr.us-east-1.amazonaws.com

echo "Pulling latest Docker image..."
docker pull $ECR_IMAGE

echo "Stopping old container (if exists)..."
docker stop myapp || true
docker rm myapp || true

echo "Starting new container..."
docker run -d --name myapp -p 8080:8080 $ECR_IMAGE

echo "Deployment complete!"
