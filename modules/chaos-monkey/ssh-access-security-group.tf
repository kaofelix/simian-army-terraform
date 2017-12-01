resource "aws_security_group" "sshaccess" {
  name = "Allow SSH Traffic"
  vpc_id = "${var.vpc_id}"

  ingress {
    from_port = 22
    protocol = "tcp"
    to_port = 22
    cidr_blocks = ["0.0.0.0/0"]
  }
}
