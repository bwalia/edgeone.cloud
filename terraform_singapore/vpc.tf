resource "aws_vpc" "prod-vpc" {
    cidr_block = "10.0.0.0/16"
    tags = {
        Name = "prod-vpc"
    }
}

resource "aws_subnet" "edgeone-subnet" {
    vpc_id = "${aws_vpc.prod-vpc.id}"
    cidr_block = "10.0.10.0/24"
    map_public_ip_on_launch = "true" //it makes this a public subnet
    availability_zone = "ap-southeast-1a"
    tags = {
        Name = "edgeone-subnet"
    }
}

# resource "aws_route_table" "edgeone-subnet-route_table" {
#   vpc_id = aws_vpc.edgeone-subnet-route_table.id

#   route = [
#     {
#       cidr_block = "10.0.1.0/24"
#       gateway_id = edgeone_igw.edgeone-subnet-route_table.id
#     },
#     {
#       ipv6_cidr_block        = "::/0"
#       egress_only_gateway_id = aws_egress_only_internet_gateway.igw.id
#     }
#   ]

#   tags = {
#     Name = "edgeone-subnet-route_table"
#   }
# }
