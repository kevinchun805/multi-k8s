docker build -t kevinchun805/multi-client:latest -t kevinchun805/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t kevinchun805/multi-server:latest -t kevinchun805/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t kevinchun805/multi-worker:latest -t kevinchun805/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push kevinchun805/multi-client:latest
docker push kevinchun805/multi-server:latest
docker push kevinchun805/multi-worker:latest

docker push kevinchun805/multi-client:$SHA
docker push kevinchun805/multi-server:$SHA
docker push kevinchun805/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=kevinchun805/multi-server:$SHA
kubectl set image deployments/client-deployment client=kevinchun805/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=kevinchun805/multi-worker:$SHA