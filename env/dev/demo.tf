module demo {
  source   = "../../modules/demo"
  
    subnets_id              = "${data.terraform_remote_state.vpc_state.subnets_id}"
    vpc_id  = "${element(data.terraform_remote_state.vpc_state.vpc_id, 0)}"
    key_name = "${var.key_name}"
    instance_type = "${var.instance_type}"
    instance_count = "${var.instance_count}"
    subnets = "${var.subnets}"
    aws_region = "${var.aws_region}"
    az = "${var.az}"

}
