# terraform으로 최초 github actions에서 사용할 assume role 생성할 때, 허용할 repo 지정
variable "allow_repo" {
  default = "repo:kyeongjun-dev/sp-labs-prac:*"
}