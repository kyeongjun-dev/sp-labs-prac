# terraform으로 리소스 생성
eks kubeconfig 예시 - context 이름을 provider.tf의 config_context에 사용
```
aws eks update-kubeconfig --name dev --profile <profile name>
kubectl config rename-context arn:aws:eks:ap-northeast-2:<account>:cluster/dev dev
```

각 디렉토리별로 provider.tf 생성 및 작성 후, 아래 명령어로 생성
```
terraform paln
terraform apply
```