
resource "aws_security_group" "sg" {
  name        = "${var.name}"
  vpc_id      = "${var.vpc_id}"
  description = "${var.description}"

  tags {
    Name = "${var.name}"
  }
}

resource "aws_security_group_rule" "sg_egress_rule" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = "${aws_security_group.sg.id}"
}

resource "aws_security_group_rule" "allow_cidrs_rule" {
  count             = "${length(var.allow_cidrs)}"
  type              = "ingress"
  from_port         = "${element(keys(var.allow_cidrs), count.index)}"
  to_port           = "${element(keys(var.allow_cidrs), count.index)}"
  protocol          = "tcp"
  cidr_blocks       = "${var.allow_cidrs[element(keys(var.allow_cidrs), count.index)]}"
  security_group_id = "${aws_security_group.sg.id}"
}

resource "aws_security_group_rule" "sg_rule_allow_sg" {
  count                    = "${var.allow_sgs["Count"]}"
  type                     = "ingress"
  from_port                = "${element(keys(var.allow_sgs), count.index)}"
  to_port                  = "${element(keys(var.allow_sgs), count.index)}"
  protocol                 = "tcp"
  source_security_group_id = "${element(values(var.allow_sgs), count.index)}"
  security_group_id        = "${aws_security_group.sg.id}"
}

