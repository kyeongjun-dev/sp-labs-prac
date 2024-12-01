## crd 설치
```
kubectl apply -f aws-load-balancer-controller-crds.yaml
```

## aws loadbalancer controller 설치
```
helm install aws-load-balancer-controller charts/aws-load-balancer-controller -f values/aws-load-balancer-controller.yaml -n kube-system
```

## 수정 항목
```
diff charts/aws-load-balancer-controller/values.yaml values/aws-load-balancer-controller.yaml 
5c5
< replicaCount: 2
---
> replicaCount: 1
32c32
<   create: true
---
>   create: false
37c37
<   name:
---
>   name: aws-load-balancer-controller
62c62
< resources: {}
---
> resources:
67,72c67,72
<   # limits:
<   #   cpu: 100m
<   #   memory: 128Mi
<   # requests:
<   #   cpu: 100m
<   #   memory: 128Mi
---
>   limits:
>     cpu: 100m
>     memory: 128Mi
>   requests:
>     cpu: 100m
>     memory: 128Mi
78c78,79
< nodeSelector: {}
---
> nodeSelector:
>   eks.amazonaws.com/nodegroup: example-2024113007024524500000000e
119c120
< clusterName:
---
> clusterName: dev
```