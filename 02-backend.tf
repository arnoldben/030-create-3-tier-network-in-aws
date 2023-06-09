# store the terraform state file in s3 and lock with dynamodb
terraform {
  backend "s3" {
    bucket         = "remote-tfstate-files"
    key            = "cicd/3-tier-network/terraform.tfstate"
    region         = "us-east-1"
    profile        = "cloud_user"
    dynamodb_table = "terraform-state-lock"
  }
}


/*
----------  create s3 bucket and dynamodb table ---------- 

aws s3api create-bucket --bucket remote-tfstate-files --region us-east-1 --profile cloud_user
aws dynamodb create-table --table-name "terraform-state-lock" --attribute-definitions AttributeName=LockID,AttributeType=S --key-schema AttributeName=LockID,KeyType=HASH --provisioned-throughput ReadCapacityUnits=5,WriteCapacityUnits=5 --region us-east-1 --profile cloud_user

---------- cleanup s3 buckets ---------- 

aws s3 rm s3://remote-tfstate-files --recursive --region us-east-1 --profile cloud_user
aws s3 rb s3://remote-tfstate-files --region us-east-1 --profile cloud_user
---
*/