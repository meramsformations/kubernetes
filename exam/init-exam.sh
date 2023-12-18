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



#Positionner le Namespace par défaut
kubectl config set-context --current --namespace=default

#Supprimer tous les Deployments du Namespace default
for deployment in $(kubectl get deploy -o name)
do
  kubectl delete $deployment 2>/dev/null
done


#Supprimer tous les pods du Namespace default
for pod in $(kubectl get pod -o name)
do
  kubectl delete $pod 2>/dev/null
done


#Supprimer tous les rs du Namespace default
for rs in $(kubectl get rs -o name)
do
  kubectl delete $rs 2>/dev/null
done


#Supprimer tous les replicationcontroller du Namespace default
for rc in $(kubectl get replicationcontroller -o name)
do
  kubectl delete $rc 2>/dev/null
done

#Supprimer toutes les confimap du Namespace default
for cm in $(kubectl get cm -o name | grep -v kube-root-ca.crt)
do
  kubectl delete $cm 2>/dev/null
done

#Supprimer tous les secret du Namespace default
for secret in $(kubectl get secret -o name | grep -v docker-hub-pull-secret)
do
  kubectl delete $secret 2>/dev/null
done


#Supprimer tous les services de type clusterIp du Namespace default
for service in $(kubectl get svc -o name | grep -v kubernetes)
do
  kubectl delete $service 2>/dev/null
done
    
 
kubectl apply -f ~/kubernetes/exam/front-fin.yaml
kubectl apply -f ~/kubernetes/exam/back-fin.yaml
kubectl apply -f ~/kubernetes/exam/front-it.yaml
kubectl apply -f ~/kubernetes/exam/back-it.yaml
kubectl apply -f ~/kubernetes/exam/cfg-fin.yaml
kubectl apply -f ~/kubernetes/exam/db-fin.yaml
kubectl apply -f ~/kubernetes/exam/cache.yaml
kubectl apply -f ~/kubernetes/exam/front-fin-srv.yaml
kubectl apply -f ~/kubernetes/exam/back-fin-srv.yaml
