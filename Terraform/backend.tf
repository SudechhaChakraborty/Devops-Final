terraform {
  backend "s3" {
    bucket = "sude-terraform"
    key = "server_name/statefile"
    region = "us-east-1"
  }
}  
