resource "aws_security_group" "elbsg" {
  name = "security_group_for_elb"
  vpc_id = "${var.vpc_id}"
  ingress {
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
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


resource "aws_elb" "elb_demo" {
  name = "terraform-elb-demo"
  #availability_zones = ["${var.az}"]
  #availability_zones = ["${data.aws_availability_zones.available.names[count.index]}"]
  security_groups = ["${aws_security_group.elbsg.id}"]
  subnets = ["${element(var.subnets_id, 0)}", "${element(var.subnets_id, 1)}"]
  
  listener = [
    {
      instance_port     = "80"
      instance_protocol = "TCP"
      lb_port           = "80"
      lb_protocol       = "TCP"
    },
    {
      instance_port     = "80"
      instance_protocol = "TCP"
      lb_port           = "80"
      lb_protocol       = "TCP"
    },
  ]

  health_check = [
    {
      target              = "HTTP:80/"
      interval            = 30
      healthy_threshold   = 2
      unhealthy_threshold = 2
      timeout             = 5
    },
  ]

cross_zone_load_balancing = false
  idle_timeout = 400
  connection_draining = true
  connection_draining_timeout = 400

  #instances                   = ["${aws_instance.web_server.*.id}", "${aws_instance.talent_server.*.id}"]
  instances                   = ["${aws_instance.web_server.*.id}"]
tags {
    Name = "terraform - elb"
  }
}

