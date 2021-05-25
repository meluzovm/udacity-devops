terraform {
  backend "s3" {
    bucket  = "mm-udacity-devsecops-terraform-state"
    key     = "mm-udacity-devsecops-terraform.state"
    region  = "eu-central-1"
    encrypt = true
  }
}
