#POD Sample

cat pod-example.yaml

# launch

kubectl apply -f pod-example.yaml

# note how applying twice leaves unchanged, but for example changing
# image does in fact change only that property

kubectl -n infra get pods
kubectl -n infra get pod  mjb-basicpod
kubectl -n infra describe pod  mjb-basicpod

# Note the extra stuff injected by "Pod Preset" template

# basic logs
kubectl -n infra logs --follow  mjb-basicpod

# go into pod
kubectl -n infra exec -it mjb-basicpod  -- /bin/bash
curl -H "X-Hello:Kubernetes"  http://127.0.0.1:8080/debug
exit

# discuss limitations of pods

# clean up
kubectl -n infra delete pod mjb-basicpod