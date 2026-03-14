#Creating VPC
resource "aws_vpc" "name" {
    cidr_block = "10.0.0.0/16"
    tags = {
        Name = "Prod-vpc"
    }
}

#Creating both public and provate subnets

resource "aws_subnet" "public" {
    vpc_id = aws_vpc.name.id
    cidr_block = "10.0.1.0/24"
    availability_zone = "us-east-1a"
    tags ={
        Name = "Public-sub"
    }
}

resource "aws_subnet" "private" {
    vpc_id = aws_vpc.name.id
    cidr_block = "10.0.2.0/24"
    availability_zone = "us-east-1b"
    tags ={
        Name = "Private-sub"
    }
}

#Creating Internet Gateway

resource "aws_internet_gateway" "ig" {
    vpc_id = aws_vpc.name.id
}

#Creating NAT gateway

resource "aws_eip" "nat" {
    domain = "vpc"
}

resource "aws_nat_gateway" "nt" {
    allocation_id = aws_eip.nat.id
    subnet_id = aws_subnet.public.id
}
#Creating pubic Route table

resource "aws_route_table" "pub-rt" {
    vpc_id = aws_vpc.name.id
    tags = {
        Name = "public-rt"
    }
    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.ig.id
    }
}

resource "aws_route_table" "pvt-rt" {
    vpc_id = aws_vpc.name.id
    tags = {
        Name = "private-rt"
    }

    route {

        cidr_block = "0.0.0.0/0"
        nat_gateway_id= aws_nat_gateway.nt.id
    }
}

#Subnet Association
resource "aws_route_table_association" "public" {
    subnet_id = aws_subnet.public.id
    route_table_id = aws_route_table.pub-rt.id
}

#Private subnet association

resource "aws_route_table_association" "private" {
    subnet_id = aws_subnet.private.id
    route_table_id = aws_route_table.pvt-rt.id
}

#Creating security group

resource "aws_security_group" "sg" {
    description = "Allow SSH and http port"
    vpc_id = aws_vpc.name.id

    ingress {
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
   ingress {
        from_port = 80
        to_port = 80
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
  egress {
    from_port = 0
    to_port = 0
    protocol = -1
    cidr_blocks = ["0.0.0.0/0"]
  }
}

#Creating EC2 instance

resource "aws_instance" "prod" {
    ami = "ami-02dfbd4ff395f2a1b"
    instance_type = "t2.micro"
    subnet_id = aws_subnet.public.id
    vpc_security_group_ids = [aws_security_group.sg.id]
    tags = {
        Name = "prod-server"
    }
}