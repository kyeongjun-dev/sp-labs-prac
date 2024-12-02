# sp-labs-prac
## 디렉토리별 설명
### terraform 디렉토리
- terraform으로 구성한 인프로 소스코드파일 및 README
- 사용방법은 terraform/README 참고

## 생성 순서
0. provider.tf.template 파일 이름을 provider.tf로 변경 후, terraform 디렉토리의 하위 디렉토리 모두 복사
1. terraform/01-share : vpc 관련 리소스, springboot 이미지가 올라가는 ecr 생성
2. terraform/02-githubactions : github actions에서 사용할 AWS Role (assume role) 생성 - 여기서 생성된 AWS Role의 arn을 github repo의 Secret에 등록
3. terraform/03-cluster : eks 클러스터 생성
4. terraform/04-aws-load-balancer-controller : eks 클러스터의 kube-system namespace에 aws load balancer controller에서 사용할 serviceAccount 생성 및 serviceAccount에서 사용할 AWS Policy, Role 생성 및 연결
5. helm 디렉토리 이동 후, README 참고하여 aws load balancer controller 설치
6. terraform/05-cluster-autoscaler : eks 클러스터의 kube-system namespace에 cluster-autoscaler servicdAccount 생성 및 serviceAccount에서 사용할 AWS Policy, Role 생성 및 연결
7. helm 디렉토리 이동 후, README 참고하여 cluster autoscaler 설치
8. github actions를 이용해 ECR에 springboot 컨테이너 이미지를 push - 소스코드는 springboot 디렉토리
9. springboot-k8s 디렉토리 이동 후, README 참고하여 Deployment, Ingress (ALB) 생성
10. 생성된 ALB 주소로 접근하여 응답 테스트 - `<alb 주소>/` : hello world 텍스트 출력, `<alb 주소>/ip` : ip주소 출력 (트래픽 라운드로빈 확인용도)

### 참고사항
- 생성되는 서브넷은 public, private 서브넷 각각 2개
- 생성하는 클러스터 이름은 `dev`로 가정 - subnet tag에 사용
- 생성되는 노드그룹의 이름은 `example`, `worker`