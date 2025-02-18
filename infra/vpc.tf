resource "aws_vpc" "cloud-native-vpc" {
    cidr_block = var.vpc_cidr_block
    enable_dns_support = true
    enable_dns_hostnames = true
    tags = {
        Name = "cloud-native-vpc"
    }
}

resource "aws_subnet" "public-subnet" {
    vpc_id = aws_vpc.cloud-native-vpc.id
    cidr_block = var.public_subnet_cidr_block
    availability_zone = "us-east-1a"
    tags = {
        Name = "cloud-native-public-subnet"
    }

  
}

resource "aws_subnet" "private-subnet" {
    vpc_id =  aws_vpc.cloud-native-vpc.id
    cidr_block = var.private_subnet_cidr_block
    availability_zone = "us-east-1b"
    tags = {
      Name = "cloud-native-private-subnet"
    }

}

resource "aws_internet_gateway" "cloud-native-igw" {
    vpc_id = aws_vpc.cloud-native-vpc.id
    tags = {
        Name = "cloud-native-igw"
    }
}
