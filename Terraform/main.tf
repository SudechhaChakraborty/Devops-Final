# Get the latest Amazon Linux 2 AMI
data "aws_ami" "amazon-linux" {
  most_recent = true

  filter {
    name   = "name"
    values = ["amzn2-ami-kernel-5.10-hvm-*-x86_64-gp2"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["amazon"]  # Required to filter public AMIs
}

# Get the default subnet for us-east-1a
data "aws_subnet" "default" {
  default_for_az     = true
  availability_zone  = "us-east-1a"
}

# Launch an EC2 instance
resource "aws_instance" "dev_machine" {
  ami           = data.aws_ami.amazon-linux.id
  instance_type = "t2.micro"
  subnet_id     = data.aws_subnet.default.id  # Needed to specify network
  key_name      = "euran-jenkins"

  tags = {
    Environment = "dev"
    Name        = "${var.name}-server"
  }
}

# Variable definition
variable "name" {
  default = "jenkins"
}

# Store Terraform state in S3
terraform {
  backend "s3" {
    bucket = "sude-terraform"
    key    = "server_name/statefile"
    region = "us-east-1"
  }
}

