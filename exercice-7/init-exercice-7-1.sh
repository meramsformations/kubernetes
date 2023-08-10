
kubectl create cm database --from-literal=host=slpafr89 --from-literal=port=671 --from-literal=user=admin
kubectl create cm logs --from-literal=log-dir=/tmp  --from-literal=log-size="5M" --from-literal=log-format=plaintext
kubectl apply -f ~/kubernetes/exercice-7/webapp-pod.yaml
