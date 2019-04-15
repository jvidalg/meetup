output "lb_url" {
	value = "${aws_elb.elb_demo.dns_name}"
}

