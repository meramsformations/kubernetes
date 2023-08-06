
kubectl create deploy redis --image=redis:not-found --replicas=2
kubectl create deploy apache --image=httpd --replicas=1

