
minikube node add --worker=true --control-plane=false
kubectl taint node minikube reserved=true:NoSchedule

