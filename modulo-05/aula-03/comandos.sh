#!/bin/bash
minikube start
kubectl get --raw /openapi/v2 > k8s.json
kubectl get --raw /openapi/v2
docker run -v $PWD/k8s.json:/app/swagger.json -p 4500:8080 swaggerapi/swagger-ui

kubectl config view
curl --cert /home/bruno/.minikube/profiles/minikube/client.crt --key  /home/bruno/.minikube/profiles/minikube/client.key --cacert /home/bruno/.minikube/ca.crt https://127.0.0.1:51253/apis/apps/v1/deployments
