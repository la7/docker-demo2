provider "aws" {
  region                      = "us-east-1"
  access_key                  = "test" # LocalStack acepta cualquier valor
  secret_key                  = "test"
  skip_credentials_validation = true
  skip_metadata_api_check     = true
  skip_requesting_account_id  = true

  endpoints {
    ec2 = "http://localhost:4566"
    rds = "http://localhost:4566"
    ecs = "http://localhost:4566"
    ecr = "http://localhost:4566"
    iam = "http://localhost:4566"
    sts = "http://localhost:4566"
  }
}