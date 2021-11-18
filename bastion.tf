resource "aws_subnet" "management" {
    vpc_id = aws_vpc.main.id
    cidr_block = var.management_subnet.cidr_block
    availability_zone = var.management_subnet.availability_zone

    tags = {
        Name        = "${var.effort}-${var.environment}-management"
        Environment = var.environment
        Effort      = var.effort
    }
}

resource "aws_route_table" "management" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.main.id
  }

  tags = {
    Name        = "${var.effort}-${var.environment}-management"
    Environment = var.environment
    Effort      = var.effort
  }
}

resource "aws_route_table_association" "management" {
  subnet_id      = aws_subnet.management.id
  route_table_id = aws_route_table.management.id
}

resource "aws_eip" "bastion" {
  vpc      = true
  instance = aws_instance.bastion.id

  tags = {
    name        = "${var.effort}-${var.environment}-bastion"
    Environment = var.environment
    effort      = var.effort
  }
}

resource "aws_instance" "bastion" {
  lifecycle {
    ignore_changes = [ami]
  }

  ami                    = var.bastion_ami_id
  instance_type          = "t2.micro"
  key_name               = aws_key_pair.bastion.key_name
  vpc_security_group_ids = [aws_security_group.bastion.id]
  subnet_id              = aws_subnet.management.id

  tags = {
    Name        = "${var.effort}-${var.environment}-bastion"
    Environment = var.environment
    Effort      = var.effort
  }

  user_data = <<EOT
#! /bin/bash
sudo apt-add-repository ppa:ansible/ansible
sudo apt-get update
sudo apt-get install python ansible -y
EOT
}

resource "aws_security_group" "bastion" {
  vpc_id = aws_vpc.main.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = var.vpn_cidr_blocks
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name        = "${var.effort}-${var.environment}-bastion"
    Environment = var.environment
    Effort      = var.effort
  }
}

resource "aws_iam_policy" "ec2_instance_connect" {
  name        = "ec2-instance-connect-${var.environment}"
  path        = "/"
  description = "Enable access to ${var.environment} bastion only with ec2 instance connect"

  policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": "ec2-instance-connect:SendSSHPublicKey",
            "Resource": "arn:aws:ec2:us-east-1:325293797198:instance/${aws_instance.bastion.id}",
            "Condition": {
                "StringEquals": {
                    "ec2:osuser": "ubuntu"
                }
            }
        },
        {
            "Effect": "Allow",
            "Action": "ec2:DescribeInstances",
            "Resource": "arn:aws:ec2:us-east-1:325293797198:instance/${aws_instance.bastion.id}"
        },
        {
            "Sid": "AllowMfaListing",
            "Effect": "Allow",
            "Action": "iam:ListMFADevices",
            "Resource": "arn:aws:iam::325293797198:user/$${aws:username}"
        },
        {
            "Sid": "AllowGetUser",
            "Effect": "Allow",
            "Action": "iam:GetUser",
            "Resource": "arn:aws:iam::325293797198:user/$${aws:username}"
        }
    ]
}
EOF
}