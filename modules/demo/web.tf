#-----compute/main.tf

data "aws_ami" "server_ami" {
  most_recent = true


  filter {
    name   = "name"
    values = ["hiring*"]
  }
  owners = ["237889007525"]
}

data "aws_ami" "talent_ami" {
  most_recent = true


  filter {
    name   = "name"
    values = ["talent*"]
  }
  owners = ["237889007525"]
}

#resource "aws_key_pair" "tf_auth" {
#  key_name   = "${var.key_name}"
#  public_key = "${file(var.public_key_path)}"
#}


resource "aws_instance" "web_server" {
  count         = "${var.instance_count}"
  instance_type = "${var.instance_type}"
  #ami           = "${data.aws_ami.server_ami.id}"
  ami = "${count.index == 0 ? data.aws_ami.server_ami.id : data.aws_ami.talent_ami.id}"

  tags {
    Name = "tf_server-${count.index +1}"
  }

  key_name               = "${var.key_name}"
  vpc_security_group_ids = ["${aws_security_group.web_sg.id}"]
  subnet_id              = "${element(var.subnets_id, 0)}"
#  subnet_id              = "${var.subnets}"
}

#resource "aws_instance" "talent_server" {
#  count         = "${var.instance_count}"
#  instance_type = "${var.instance_type}"
#  ami           = "${data.aws_ami.talent_ami.id}"

#  tags {
#    Name = "tf_server-${count.index +1}"
#  }

#  key_name               = "${var.key_name}"
#  vpc_security_group_ids = ["${aws_security_group.web_sg.id}"]
#  subnet_id              = "${var.subnets}"
#}

resource "aws_security_group" "web_sg" {
  name = "security_group_for_web"
  vpc_id = "${var.vpc_id}"
  ingress {
    from_port = 80
    to_port = 80
    protocol = "tcp"
    security_groups = ["${aws_security_group.elbsg.id}"]
#    cidr_blocks = ["0.0.0.0/0"]
  }
egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
lifecycle {
    create_before_destroy = true
  }
}