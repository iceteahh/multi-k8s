docker build -t loopbreaker/multi-client:latest -t loopbreaker/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t loopbreaker/multi-server:latest -t loopbreaker/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t loopbreaker/multi-worker:latest -t loopbreaker/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push loopbreaker/multi-client:latest
docker push loopbreaker/multi-server:latest
docker push loopbreaker/multi-worker:latest
docker push loopbreaker/multi-client:$SHA
docker push loopbreaker/multi-server:$SHA
docker push loopbreaker/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployment/client-deployment client=loopbreaker/multi-client:$SHA
kubectl set image deployment/server-deployment server=loopbreaker/multi-server:$SHA
kubectl set image deployment/worker-deployment worker=loopbreaker/multi-worker:$SHA