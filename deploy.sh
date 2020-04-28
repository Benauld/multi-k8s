# build all images
# applying 2 tags to this - first uses latest. 2nd adds variable SHA from travis file from git commit version number
docker build -t benauld/multi-client:latest -t benauld/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t benauld/multi-server:latest -t benauld/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t benauld/multi-worker:latest -t benauld/multi-worker:$SHA -f ./worker/Dockerfile ./worker
# need to push both tags explicitly
docker push benauld/multi-client:latest
docker push benauld/multi-server:latest
docker push benauld/multi-worker:latest
docker push benauld/multi-client:$SHA
docker push benauld/multi-server:$SHA
docker push benauld/multi-worker:$SHA
# apply configs in the k8s folder
kubectl apply -f k8s
# imperatively set images
kubectl set image deployments/server-deployment server=benauld/multi-server:$SHA
kubectl set image deployments/client-deployment server=benauld/multi-client:$SHA
kubectl set image deployments/worker-deployment server=benauld/multi-worker:$SHA