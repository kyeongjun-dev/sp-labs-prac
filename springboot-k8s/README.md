## 리소스 생성
```
kubectl create ns springboot
kubectl apply -f springboot.yaml -n springboot
kubectl apply -f ingress.yaml -n springboot
```

## Deployment
- `nodeAffinity`를 통해 role이 worker인 노드에 파드 생성
- `topologySpreadConstraints`를 통해 `ap-northeast-2a`, `ap-northeast-2c` 존에 각각 1개씩 파드가 생성되도록 설정

## Ingress
- 퍼블릭 서브넷 `vpc-dev-public-ap-northeast-2a`, `vpc-dev-public-ap-northeast-2c`에 ALB 생성
- springboot Service의 8080포트로 트래픽 라우팅