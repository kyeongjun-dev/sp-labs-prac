resource "aws_ecr_repository" "springboot" {
  name                 = "springboot"
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = false
  }
}