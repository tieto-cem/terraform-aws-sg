
variable "name" {
  description = "Security group name"
}

variable "description" {
  description = "Security group description"
  default = "Managed by Terraform"
}

variable "vpc_id" {
  description = "VPC where security group is added"
}

variable "allow_cidrs" {
  type = "map"
  default = {}
  description = <<EOF
      A mapping between ports and list of allowed CIDR blocks. Note that ports should be mapped only once.
      Example:
        {
          "22" = ["1.1.1.1/32", "2.2.2.2/32"]
          "80" = ["1.1.1.1/32"]
        }
EOF
}


variable "allow_sgs" {
  type = "map"
  default = {
    "Count" = 0
  }
  description = <<EOF
      A mapping between ports and allowed security groups. As a workaround to Terraform limitation, you need to specify rule count under key "Count".
      Example:
        {
          "22" = "$${aws_security_group.sg1.id}"
          "80" = "$${aws_security_group.sg2.id}"
          "Count" = 2
        }
EOF
}




