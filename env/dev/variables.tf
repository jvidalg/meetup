variable "key_name" {
	default = "default-terraform-account"
}

variable "instance_type" {
	description = "describe your variable"
	default     = "t2.micro"
}

variable "instance_count" {
	description = "describe your variable"
	default     = "2"
}

variable "subnets" {
	description = "describe your variable"
	default     = "subnet-01ace27b15fec8381"
}

variable "aws_region" {

	default = "us-east-1"
}

variable "az" {
	description = "describe your variable"
	default     = "us-east-1c"
}