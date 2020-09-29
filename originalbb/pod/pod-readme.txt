#POD Sample

cat pod-example.yaml

# launch

kubectl apply -f pod-example.yaml

# note how applying twice leaves unchanged, but for example changing
# image does in fact change only that property

kubectl -n infra get pods
kubectl -n infra get pod  pod-example
kubectl -n infra describe pod  pod-example

# Note the extra stuff injected by "Pod Preset" template

# basic logs
kubectl -n infra logs --follow  pod-example

# go into pod
kubectl -n infra exec -it pod-example -- /bin/bash
curl -H "X-Hello:Kubernetes"  http://127.0.0.1:8080/debug

# notice killing it restarts
exit

# discuss limitations of pods

# clean up
kubectl -n infra delete pod pod-example