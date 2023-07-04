resource "aws_vpc" "vpc-wiki" {
  cidr_block = var.cidr
  tags = {
    Name = var.name
  }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc-wiki.id

  tags = {
    Name = var.name
  }
}

resource "aws_subnet" "private" {
  vpc_id     = aws_vpc.vpc-wiki.id
  cidr_block = var.private_subnets
  availability_zone = var.az[0]
  count             = length(var.private_subnets)

  tags = {
    Name = var.name
  }
}

resource "aws_subnet" "public" {
  vpc_id     = aws_vpc.vpc-wiki.id
  cidr_block = var.public_subnets
  availability_zone = var.az[0]
  count             = length(var.public_subnets)
  
  tags = {
    Name = var.name
  }
}

resource "aws_route_table" "rt_public" {
  vpc_id = aws_vpc.vpc-wiki.id

  route {
    cidr_block = var.cidr_rt
    gateway_id = aws_internet_gateway.igw.id
  }

}

resource "aws_route_table_association" "a" {
  subnet_id      = var.public_subnets
  route_table_id = aws_route_table.rt_public.id
}

resource "aws_nat_gateway" "ngw" {
  allocation_id = aws_eip.nat.id
  subnet_id     = var.private_subnets
  depends_on    = [aws_internet_gateway.igw]

  tags = {
    Name = var.name
  }
}

resource "aws_eip" "nat" {
  vpc   = true
}

resource "aws_route_table" "rt_private" {
  vpc_id = aws_vpc.vpc-wiki.id

  route {
    cidr_block = var.cidr_rt
    nat_gateway_id = aws_nat_gateway.ngw.id
  }

}

resource "aws_route_table_association" "b" {
  subnet_id      = var.private_subnets
  route_table_id = aws_route_table.rt_private.id
}

