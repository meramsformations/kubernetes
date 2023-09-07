
NODE_COUNT=$(kubectl get nodes --no-headers=true | wc -l)

if [ $NODE_COUNT -eq 1 ]
then
  minikube node add --worker=true --control-plane=false
fi



