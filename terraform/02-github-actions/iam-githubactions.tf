# aws Identity provider 생성 - github
resource "aws_iam_openid_connect_provider" "githb_actions_oidc_provider" {
  url = "https://token.actions.githubusercontent.com"

  client_id_list = [
    "sts.amazonaws.com",
  ]

  thumbprint_list = ["6938fd4d98bab03faadb97b34396831e3780aea1"]
}

# github actions에서 사용할 assume role 생성
resource "aws_iam_role" "github_actions_role" {
    name = "githubActionsRole"

    assume_role_policy = <<POLICY
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Principal": {
                "Federated": "${aws_iam_openid_connect_provider.githb_actions_oidc_provider.id}"
            },
            "Action": "sts:AssumeRoleWithWebIdentity",
            "Condition": {
                "StringLike": {
                    "token.actions.githubusercontent.com:sub": "${var.allow_repo}"
                },
                "StringEquals": {
                    "token.actions.githubusercontent.com:aud": "sts.amazonaws.com"
                }
            }
        }
    ]
}
POLICY
}

# ECR에 push할 수 있도록 PowerUser 권한 추가
resource "aws_iam_role_policy_attachment" "AmazonEC2ContainerRegistryPowerUser" {
    policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryPowerUser"
    role       = aws_iam_role.github_actions_role.name
}