# Resolve the current Amazon Linux 2023 image for this region.
data "aws_ssm_parameter" "amazon_linux" {
  name = "/aws/service/ami-amazon-linux-latest/al2023-ami-kernel-default-x86_64"
}

# Our first resource: one EC2 virtual machine.
resource "aws_instance" "web" {
  ami           = nonsensitive(data.aws_ssm_parameter.amazon_linux.value)
  instance_type = "t3.micro"

  tags = {
    Name = "roboshop-web"
  }
}

output "instance_id" {
  description = "ID of our first EC2 instance."
  value       = aws_instance.web.id
}
