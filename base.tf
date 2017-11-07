provider "aws" {
  region = "${var.region}"
}

resource "aws_instance" "jenkins" {
  count = "1"
  ami = "${lookup(var.ami, var.region)}"
  instance_type = "t2.micro"
  user_data = "${data.template_file.bootstrap.rendered}"

  vpc_security_group_ids = ["${aws_security_group.jenkins_sg1.id}"]
  key_name = "brunns"
  }

data "template_file" "bootstrap" {
  template = "${file("${path.module}/bootstrap.sh")}"
  vars = {
    jenkins_version = "2.68-1.1"
  }
}

resource "aws_security_group" "jenkins_sg1" {
  name = "jenkins-sg1"
  description = "HTTP & SSH in, everything out."

  ingress {
    from_port = 8080
    to_port = 8080
    protocol ="tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress{
    from_port = 22
    to_port = 22
    protocol ="tcp"
    cidr_blocks = ["0.0.0.0/0"] 
  }

  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

output "instance-ip" {
  value = ["${aws_instance.jenkins.*.public_ip}"]
}
