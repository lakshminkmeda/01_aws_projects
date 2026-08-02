# Create EC2 instance for public subnet 01
resource "aws_instance" "web_server_01" {
  ami                         = data.aws_ami.amazonlinux2.id
  instance_type               = "t3.micro"
  security_groups             = [aws_security_group.web_sg.id]
  subnet_id                   = aws_subnet.public.id
  associate_public_ip_address = true
  user_data                   = file("${path.module}/userdata.sh")
  key_name                    = "lnkm"
}