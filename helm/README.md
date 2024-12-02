# aws loadbalancer controller
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
>   name: example
119c120
< clusterName:
---
> clusterName: dev
```
---
# cluster autoscaler
## 설치
```
helm install cluster-autoscaler charts/cluster-autoscaler -f values/cluster-autoscaler.yaml -n kube-system
```

## 수정 항목
```
diff charts/cluster-autoscaler/values.yaml values/cluster-autoscaler.yaml 
17c17
<   clusterName:  # cluster.local
---
>   clusterName: dev
76c76
< awsRegion: us-east-1
---
> awsRegion: ap-northeast-2
185c185
<   # balance-similar-node-groups: true
---
>   balance-similar-node-groups: true
195c195
<   # skip-nodes-with-system-pods: true
---
>   skip-nodes-with-system-pods: false
288c288,289
< nodeSelector: {}
---
> nodeSelector:
>   name: example
336c337
<     create: true
---
>     create: false
338c339
<     name: ""
---
>     name: "cluster-autoscaler"
```