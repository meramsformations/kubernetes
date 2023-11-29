#Ajouter la configuration Docker Hub avec le compte pro de esilv
kubectl get secret docker-hub-pull-secret -n default -o name > /dev/null 2>/dev/null
if [ $? -ne 0 ]
then
 kubectl create secret docker-registry docker-hub-pull-secret --docker-server="https://index.docker.io/v1/" --docker-username=crdevinci --docker-password=dckr_pat_YfO7bNq4XbdFL0hcZlpm7YjUEiU -n default
fi

kubectl get sa default -n default -o yaml 2>/dev/null | grep -i docker-hub-pull-secret >/dev/null 2>/dev/null
if [ $? -ne 0 ]
then
  kubectl patch serviceaccount default -p '{"imagePullSecrets": [{"name": "docker-hub-pull-secret"}]}' -n default
fi

kubectl apply -f ~/kubernetes/exercice-15/httpdmark.yaml
kubectl apply -f ~/kubernetes/exercice-15/httpdit.yaml
kubectl apply -f ~/kubernetes/exercice-15/httpdfin.yaml
kubectl apply -f ~/kubernetes/exercice-15/tomcatmark.yaml
kubectl apply -f ~/kubernetes/exercice-15/tomcatit.yaml
kubectl apply -f ~/kubernetes/exercice-15/tomcatfin.yaml
kubectl apply -f ~/kubernetes/exercice-15/deployfront.yaml
kubectl apply -f ~/kubernetes/exercice-15/deployback.yaml
