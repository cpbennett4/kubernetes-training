# launch
kubectl apply -f deployment-example.yaml
# adoption of pods via selectors

kubectl -n infra get pods

# here's a sample
# note pods are randomly named! prefix is the deployment name

#deployment-example-858bf896c6-6xsnh           0/1     Running   0          9s
#deployment-example-858bf896c6-77zhh           0/1     Running   0          9s
#deployment-example-858bf896c6-vcrqt           0/1     Running   0          9s

kubectl -n infra get deployment deployment-example
#mbell@sfo17m002839 intro (master) $
#NAME                 READY   UP-TO-DATE   AVAILABLE   AGE
#deployment-example   3/3     3            3           18m

kubectl -n infra describe deployment deployment-example

kubectl -n infra get rs

# deployment-example-858bf896c6
# kubectl -n infra describe rs deployment-example-858bf896c6


kubectl -n infra delete deployment deployment-example
