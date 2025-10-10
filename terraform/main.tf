# -- DATA SOURCE TO FIND THE LATEST UBUNTU AMI --
# This is the "smart" way. Instead of hard-coding an AMI ID,
# this block asks AWS to find the latest Ubuntu 22.04 LTS AMI for us.
data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # This is the official ID for Canonical (the makers of Ubuntu)
}


# -- NETWORKING --

# Create a Security Group (like a firewall) for our EC2 instance.
resource "aws_security_group" "app_sg" {
  name        = "${var.project_name}-sg"
  description = "Allow SSH and App traffic"

  # Inbound rule for SSH (Port 22) so we can connect to the server.
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # Allows connection from any IP
  }

  # Inbound rule for our Node.js app (Port 3000).
  ingress {
    from_port   = 3000
    to_port     = 3000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # Allows traffic from any IP
  }

  # Outbound rule to allow the server to connect to the internet.
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.project_name}-sg"
  }
}

# -- SSH KEY --

# Create a new EC2 key pair for SSH access.
# Terraform will generate this key for us.
resource "tls_private_key" "app_key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "generated_key" {
  key_name   = var.key_name
  public_key = tls_private_key.app_key.public_key_openssh
}

# Save the private key to a file on our local machine.
# IMPORTANT: We must never commit this file to Git.
resource "local_file" "ssh_private_key" {
  content  = tls_private_key.app_key.private_key_pem
  filename = "${var.key_name}.pem"
  file_permission = "0600" # Adds read/write permissions for the owner only
}

# -- EC2 INSTANCE --

# Create the EC2 instance (our virtual server).
# This is a t2.micro instance, which is eligible for the AWS Free Tier.
resource "aws_instance" "app_server" {
  # This is the CHANGED line. Instead of a hard-coded ID,
  # we now use the ID found by our data source block above.
  ami           = data.aws_ami.ubuntu.id
  instance_type = "t2.micro"

  # Associate our security group and key pair with the instance.
  vpc_security_group_ids = [aws_security_group.app_sg.id]
  key_name               = aws_key_pair.generated_key.key_name

  tags = {
    Name = var.project_name
  }
}