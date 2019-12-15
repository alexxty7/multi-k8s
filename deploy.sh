docker build -t alexkatulskiy/multi-client:latest -t alexkatulskiy/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t alexkatulskiy/multi-server:latest -t alexkatulskiy/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t alexkatulskiy/multi-worker:latest -t alexkatulskiy/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push alexkatulskiy/multi-client:latest
docker push alexkatulskiy/multi-server:latest
docker push alexkatulskiy/multi-worker:latest

docker push alexkatulskiy/multi-client:$SHA
docker push alexkatulskiy/multi-server:$SHA
docker push alexkatulskiy/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/client-deployment client=alexkatulskiy/multi-client:$SHA
kubectl set image deployments/server-deployment server=alexkatulskiy/multi-server:$SHA
kubectl set image deployments/worker-deployment worker=alexkatulskiy/multi-worker:$SHA

