resource "aws_iam_role" "eks_pod_identity_ecr" {
  name = "eks-pod-ecr-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          Service = "pods.eks.amazonaws.com"
        }
        Action = [
            "sts:AssumeRole",
            "sts:TagSession"
        ]
      }
    ]
  })
}


resource "aws_iam_role_policy_attachment" "ecr_full_access" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryFullAccess"
  role       = aws_iam_role.eks_pod_identity_ecr.name
}