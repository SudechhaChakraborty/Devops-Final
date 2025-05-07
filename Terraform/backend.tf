terraform {
  backend "s3" {
    bucket = "sude-terraform"
    key = "server_name/statefile"
    region = "ap-south-1"
  }
}  
