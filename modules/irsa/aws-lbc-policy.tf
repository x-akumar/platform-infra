resource "aws_iam_policy" "aws_lbc" {
  name   = "AWSLoadBalancerControllerIAMPolicy"
  policy = file("${path.module}/aws-load-balancer-controller-policy.json")
}

resource "aws_iam_role_policy_attachment" "aws_lbc" {
  role       = aws_iam_role.aws_lbc.name
  policy_arn = aws_iam_policy.aws_lbc.arn
}