[![CircleCI](https://circleci.com/gh/tieto-cem/terraform-aws-sg.svg?style=shield&circle-token=b2c2e0eb964979cedf5dfd87904b7eee291f4f81)](https://circleci.com/gh/tieto-cem/terraform-aws-sg)

Terraform Security Group module
====================

Terraform module for creating AWS Security Groups. This module provides
simple and consistent interface for defining security groups

Limitations 
-----------

Ease of use comes with following limitations: 

* TCP protocol support only (tcp is used most of the time anyway)
* Cannot specify port ranges
* Cannot specify egress rule (all outbound connections are allowed for now)

Usage
-----

```hcl

module "sg_1" {
  source      = "github.com/tieto-cem/terraform-aws-sg?ref=v0.1.0"
  name        = "sg-1"
  vpc_id      = "vpc-12345678"
  allow_sgs = {
    "22"    = "${aws_security_group.sg1.id}"
    "80"    = "${aws_security_group.sg2.id}"
    "Count" = 2
  }
  allow_cidrs = {
    "22" = ["1.2.3.4/0"]
    "80" = ["2.3.4.5/32", "1.2.3.4/32"]
  }
}

```   

Example
-------

* [Simple example](https://github.com/tieto-cem/terraform-aws-sg/tree/master/example)