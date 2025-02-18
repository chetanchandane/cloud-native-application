resource "aws_internet_gateway" "igw" {
    vpc_id = aws_vpc.main.id

    tags = {
        Name = "main-internet-gateway"
    }
}

resource "aws_nat_gateway" "nat" {
    allocation_id = aws_eip.nat-elastic-ip.id
    subnet_id     = aws_subnet.public-subnet.id

    tags = {
        Name = "main-nat-gateway"
    }
}

resource "aws_eip" "nat-elastic-ip" {
    domain = "vpc"
    tags = {
        Name = "main-nat-eip"
    }
}

