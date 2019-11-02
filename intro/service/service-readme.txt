# we probably won't cover services much in this first course, but you should know they exist
# They are a "load balancer".
# they adopt pods (via selector)
# pods that are Ready (readinessProbe) will be routed to, ones that are not ready will not be routed to
#
kubectl apply -f ../deployment/deployment-example.yaml
kubectl -n infra apply -f service-example.yaml

#  basic and advanced look
kubectl -n infra get service service-example
kubectl -n infra describe endpoints service-demo

# clean up
kubectl -n infra describe endpoints service-demo
# notice deleting the service doesn't touch the deployment
kubectl -n infra delete deployment deployment-example