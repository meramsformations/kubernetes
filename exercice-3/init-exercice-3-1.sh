
kubectl create deploy redis  --image=redis --replicas=2
kubectl create deploy apache --image=httpd --replicas=1
kubectl create deploy tomcat --image=tomcat --replicas=0
kubectl create deploy nginx  --image=nginx:last-one --replicas=2
