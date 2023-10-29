provider "aws" {
  access_key = var.access_key
  secret_key = var.secret_key
  region     = "us-east-1"
}

provider "aws" {
  access_key = var.access_key
  secret_key = var.secret_key
  alias = "west"
  region     = "us-west-2"
}

resource "aws_instance" "eastbank1_dep6" {
  ami                    = "ami-053b0d53c279acc90"
  instance_type          = "t2.medium"
  subnet_id              = aws_subnet.pubsub1.id
  vpc_security_group_ids = [aws_security_group.web_ssh.id]
  availability_zone = "us-east-1a"
  user_data              = file("deploy.sh")
  key_name = "d6_key"


  tags = {
    "Name" = "eastbank1_dep6"
  }
}

resource "aws_instance" "eastbank2_dep6" {
  ami                    = "ami-053b0d53c279acc90"
  instance_type          = "t2.medium"
  subnet_id              = aws_subnet.pubsub2.id
  vpc_security_group_ids = [aws_security_group.web_ssh.id]
  availability_zone = "us-east-1b"
  user_data              = file("deploy.sh")
  key_name = "d6_key"

  tags = {
    "Name" = "eastbank2_dep6"
  }
}


resource "aws_security_group" "web_ssh" {
  name        = "d6_sg"
  description = "open ssh traffic"
  vpc_id      = aws_vpc.east_vpc.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [var.cidr_blocks]

  }

  ingress {
    from_port   = 8000
    to_port     = 8000
    protocol    = "tcp"
    cidr_blocks = [var.cidr_blocks]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = [var.cidr_blocks]
  }

  tags = {
    "Name" : "d6_sg"
    "Terraform" : "true"
  }

}

resource "aws_vpc" "east_vpc" {
  cidr_block       = "10.0.0.0/16"
  instance_tenancy = "default"

  tags = {
    Name = "D6vpc"
  }
}

resource "aws_subnet" "pubsub1" {
  vpc_id                  = aws_vpc.east_vpc.id
  cidr_block              = "10.0.1.0/24"
  availability_zone       = "us-east-1a"
  map_public_ip_on_launch = true

  tags = {
    Name = "pubsub1"
  }
}

resource "aws_subnet" "pubsub2" {
  vpc_id                  = aws_vpc.east_vpc.id
  cidr_block              = "10.0.2.0/24"
  availability_zone       = "us-east-1b"
  map_public_ip_on_launch = true

  tags = {
    Name = "pubsub2"
  }
}

resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.east_vpc.id

  tags = {
    Name = "main"
  }
}

resource "aws_default_route_table" "main" {
  default_route_table_id = aws_vpc.east_vpc.default_route_table_id
  
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }
}

#outputs new instance IP in the terminal 
output "instance_ip" {
  value = aws_instance.eastbank1_dep6.public_ip
}

output "instance_ip2" {
  value = aws_instance.eastbank2_dep6.public_ip
}

resource "aws_instance" "westbank1_dep6" {
  provider = aws.west
  ami                    = "ami-0cbd40f694b804622"
  instance_type          = "t2.medium"
  subnet_id              = aws_subnet.west_subnet1.id
  vpc_security_group_ids = [aws_security_group.web_ssh.id]
  availability_zone = "us-west-2a"
  user_data              = file("deploy.sh")
  key_name = "d6_key"


  tags = {
    "Name" = "westbank1_dep6"
  }
}

resource "aws_instance" "westbank2_dep6" {
  ami                    = "ami-0cbd40f694b804622"
  instance_type          = "t2.medium"
  subnet_id              = aws_subnet.west_subnet1.id
  vpc_security_group_ids = [aws_security_group.west_sg.id]
  availability_zone = "us-west-2b"
  user_data              = file("deploy.sh")
  key_name = "d6_key"


  tags = {
    "Name" = "westbank2_dep6"
  }
}

resource "aws_vpc" "west_vpc" {
  provider = aws.west
  cidr_block       = "10.0.0.0/16"
  instance_tenancy = "default"

  tags = {
    Name = "D6west_vpc"
  }
}

resource "aws_subnet" "west_subnet" {
  provider = aws.west
  vpc_id                  = aws_vpc.west_vpc.id
  cidr_block              = "10.0.1.0/24"
  availability_zone       = "us-west-2a"
  map_public_ip_on_launch = true

  tags = {
    Name = "west_subnet1"
  }
}

resource "aws_subnet" "west_subnet1" {
  provider = aws.west
  vpc_id                  = aws_vpc.west_vpc.id
  cidr_block              = "10.0.2.0/24"
  availability_zone       = "us-west-2b"
  map_public_ip_on_launch = true

  tags = {
    Name = "west_subnet2"
  }
}

resource "aws_security_group" "west_sg" {
  provider = aws.west
  name        = "westd6_sg"
  description = "open ssh traffic"
  vpc_id      = aws_vpc.west_vpc.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [var.cidr_blocks]

  }

  ingress {
    from_port   = 8000
    to_port     = 8000
    protocol    = "tcp"
    cidr_blocks = [var.cidr_blocks]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = [var.cidr_blocks]
  }

  tags = {
    "Name" : "westd6_sg"
    "Terraform" : "true"
  }

}

resource "aws_internet_gateway" "west_gw" {
  provider = aws.west
  vpc_id = aws_vpc.west_vpc.id

  tags = {
    Name = "main"
  }
}

resource "aws_default_route_table" "west_route" {
  provider = aws.west
  default_route_table_id = aws_vpc.west_vpc.default_route_table_id
  
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.west_gw.id
  }
}
