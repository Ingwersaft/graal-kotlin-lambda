#!/usr/bin/env bash
yum -y install git java-1.8.0-openjdk
git clone https://github.com/Ingwersaft/graal-kotlin-lambda.git /home/ec2-user/graal-kotlin-lambda
chown ec2-user:ec2-user /home/ec2-user/graal-kotlin-lambda

