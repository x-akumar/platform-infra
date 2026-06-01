terraform {
  backend "s3" {
    bucket       = "myprojecttfstate01"
    key          = "accounts/dev-account/regions/us-east-1/dev/cluster-1/terraform.tfstate"
    region       = "us-east-1"
    use_lockfile = true
  }
}
