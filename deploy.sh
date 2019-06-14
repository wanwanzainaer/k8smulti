docker build -t wanwanzainaer/multi-client:latest -t wanwanzainaer/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t wanwanzainaer/multi-server:latest -t wanwanzainaer/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t wanwanzainaer/multi-worker:latest -t wanwanzainaer/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push wanwanzainaer/multi-client:latest
docker push wanwanzainaer/multi-server:latest
docker push wanwanzainaer/multi-worker:latest

docker push wanwanzainaer/multi-client:$SHA
docker push wanwanzainaer/multi-server:$SHA
docker push wanwanzainaer/multi-worker:$SHA

kubectl apply -f k8s

kubectl set image deployments/server-deployment server=wanwanzainaer/multi-server:$SHA
kubectl set image deployments/client-deployment client=wanwanzainaer/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=wanwanzainaer/multi-worker:$SHA