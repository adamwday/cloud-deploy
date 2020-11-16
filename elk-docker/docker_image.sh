#!/bin/bash


#Runs the docker login command
aws ecr get-login --no-include-email --region us-east-1

#Builds the docker image.
docker build -t elasticsearch .

#Tags docker image before we push to the ECR
docker tag elasticsearch:latest 765717427546.dkr.ecr.us-east-1.amazonaws.com/elasticsearch:latest

#pushes docker image to AWS ECR
docker push 765717427546.dkr.ecr.us-east-1.amazonaws.com/elasticsearch:latest