data "aws_iam_policy_document" "cluster_autoscaler_assume_role" {

  statement {
    effect = "Allow"

    actions = [
      "sts:AssumeRoleWithWebIdentity"
    ]

    principals {
      type = "Federated"

      identifiers = [
        var.oidc_provider_arn
      ]
    }

    condition {
      test = "StringEquals"

      variable = "${replace(var.oidc_issuer_url, "https://", "")}:sub"

      values = [
        "system:serviceaccount:kube-system:cluster-autoscaler"
      ]
    }
  }
}

resource "aws_iam_role" "cluster_autoscaler" {

  name = "cluster-autoscaler-role"

  assume_role_policy = data.aws_iam_policy_document.cluster_autoscaler_assume_role.json
}