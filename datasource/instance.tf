data "aws_availability_zones" "available" {
  #above line will fetch all the availability zones which are available in AWS
}

data "aws_ami" "latest-linux" {
  most_recent = true
  owners      = ["amazon"]
  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-2.0.????????.?-x86_64-gp2"]

  }
  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}
resource "aws_instance" "datasource" {
  ami               = data.aws_ami.latest-linux.id
  instance_type     = "t2.micro"
  availability_zone = data.aws_availability_zones.available.names[1]
  tags = {
    Name = "datainstance"
  }
}

/*data "aws_instance" "datasource" {

  filter {
    name   = "tag:Name"
    values = ["datainstance"]
  }
  depends_on = [ "aws_instance.datasource" ]
}
output "data_from_instance" {
  value = data.aws_instance.datasource.public_ip
}*/