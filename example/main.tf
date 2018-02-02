provider "aws" {
  region = "eu-west-1"
}

data "aws_vpc" "default" {
  default = true
}

module "allow_cidr_blocks_sg" {
  source      = ".."
  name        = "allow-cird-blocks-sg"
  vpc_id      = "${data.aws_vpc.default.id}"
  allow_cidrs = {
    "22" = ["0.0.0.0/0"]
    "80" = ["0.0.0.0/0", "1.2.3.4/32"]
  }
}

module "allow_sgs_sg" {
  source    = ".."
  name      = "allow-sgs-sg"
  vpc_id    = "${data.aws_vpc.default.id}"
  allow_sgs = {
    "22"    = "${module.allow_cidr_blocks_sg.id}"
    "Count" = 1
  }
}

module "allow_combination" {
  source      = ".."
  name        = "allow-combination-sg"
  vpc_id      = "${data.aws_vpc.default.id}"
  allow_cidrs = {
    "22" = ["0.0.0.0/0"]
  }
  allow_sgs   = {
    "22"    = "${module.allow_cidr_blocks_sg.id}"
    "Count" = 1
  }
}