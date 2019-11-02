# This is not in scope for our presentation but here in case someone asks
# example of a scheduled job
kubectl apply -f job-example.yaml

kubectl -n infra get cronjob

kubectl -n infra get jobs --watch

kubectl -n infra delete cronjob job-example