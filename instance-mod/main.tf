data "aws_region" "current" {}

resource "aws_vpc" "main" {
  cidr_block           = "10.0.0.0/16"
  instance_tenancy     = "default"
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name       = "Mattias"
    Maintainer = "Mattias"
    Service    = "Hello"
  }
}

resource "aws_subnet" "other" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = "10.0.2.0/24"
  map_public_ip_on_launch = true
  availability_zone       = "eu-north-1a"

  tags = {
    Name       = "Mattias"
    Maintainer = "Mattias"
    Service    = "Hello"
  }
}

resource "aws_subnet" "main_subnet" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = "10.0.1.0/24"
  map_public_ip_on_launch = true
  availability_zone       = "eu-north-1b"

  tags = {
    Name       = "Mattias"
    Maintainer = "Mattias"
    Service    = "Hello"
  }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name       = "Mattias"
    Maintainer = "Mattias"
    Service    = "Hello"
  }
}

resource "aws_route_table" "main" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name       = "Mattias"
    Maintainer = "Mattias"
    Service    = "Hello"
  }
}

resource "aws_route_table_association" "route-tbl-link1" {
  subnet_id      = aws_subnet.main_subnet.id
  route_table_id = aws_route_table.main.id
}

resource "aws_security_group" "allow_ssh" {
  name        = "allow_ssh"
  description = "Allow SSH inbound traffic"
  vpc_id      = aws_vpc.main.id


  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }


  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name       = "Mattias"
    Maintainer = "Mattias"
    Service    = "Hello"
  }
}

resource "aws_security_group" "allow_http" {
  name        = "allow_http"
  description = "Allow http inbound traffic"
  vpc_id      = aws_vpc.main.id

  ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }


  tags = {
    Name       = "Mattias"
    Maintainer = "Mattias"
    Service    = "Hello"
  }
}


resource "aws_key_pair" "mattias" {
  key_name   = "mattias-public-key"
  public_key = var.public-key
}

resource "aws_instance" "instance" {
  ami                         = lookup(var.amis, data.aws_region.current.name)
  instance_type               = "t3.micro"
  key_name                    = aws_key_pair.mattias.key_name
  associate_public_ip_address = true

  subnet_id = aws_subnet.main_subnet.id

  vpc_security_group_ids = [
    aws_security_group.allow_ssh.id,
    aws_security_group.allow_http.id
  ]

  tags = {
    Name       = "Mattias"
    Maintainer = "Mattias"
    Service    = "Hello"
  }
}

resource "aws_lb" "main" {
  name = "lb"
  security_groups = [
    aws_security_group.allow_http.id
  ]

  subnets = [aws_subnet.main_subnet.id, aws_subnet.other.id]

  tags = {
    Maintainer = "Mattias"
  }
}

resource "aws_lb_target_group" "main" {
  port                 = 8080
  protocol             = "HTTP"
  vpc_id               = aws_vpc.main.id
  deregistration_delay = 5

  health_check {
    enabled             = true
    healthy_threshold   = 5
    interval            = 30
    matcher             = "200"
    path                = "/"
    port                = "traffic-port"
    protocol            = "HTTP"
    timeout             = 5
    unhealthy_threshold = 2
  }

  tags = {
    Maintainer = "Mattias"
  }
}

resource "aws_lb_listener" "main" {
  load_balancer_arn = aws_lb.main.arn
  protocol          = "HTTP"
  port              = 80

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.main.arn
  }
}
