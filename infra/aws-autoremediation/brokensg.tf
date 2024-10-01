resource "aws_security_group" "presto-resp-rem-test-all" {
  name        = "presto-resp-rem-test-all"
  description = "Allows incoming access from any internet address (RR Testing, unattached)"
  vpc_id      = "vpc-009cfc112c9c15d8a" 

  ingress {
    description      = "Allow all from anywhere"
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
}

resource "aws_security_group" "presto-resp-rem-test-ssh" {
  name        = "presto-resp-rem-test-ssh"
  description = "Allows incoming SSH access from any internet address (RR Testing, unattached)"
  vpc_id      = "vpc-009cfc112c9c15d8a" 

  ingress {
    description      = "Allow SSH from anywhere"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
}