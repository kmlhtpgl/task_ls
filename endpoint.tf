provider "aws" {
  region = "us-east-1" # change to your region
}

# Example: Security Group for the VPC Endpoint
resource "aws_security_group" "vpc_endpoint_sg" {
  name        = "vpc-endpoint-sg"
  description = "Security group for VPC endpoint"
  vpc_id      = var.vpc_id

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # adjust this to be more restrictive
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "vpc-endpoint-sg"
  }
}

# Example: VPC Endpoint (Interface type for S3)
resource "aws_vpc_endpoint" "s3_interface" {
  vpc_id            = var.vpc_id
  service_name      = "com.amazonaws.${var.aws_region}.s3"
  vpc_endpoint_type = "Interface"
  subnet_ids        = var.subnet_ids
  security_group_ids = [
    aws_security_group.vpc_endpoint_sg.id
  ]

  private_dns_enabled = true

  tags = {
    Name = "s3-vpc-endpoint"
  }
}
