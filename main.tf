provider "aws" {
  region = "${var.region}"
  profile = "${var.profile}"
}

data "aws_availability_zones" "current" {}

module "chaos_monkey" {
  source = "./modules/chaos-monkey"
  ami_id = "${var.chaos_monkey_ami_id}"
  sshkeyname = "${var.sshkeyname}"
  name_prefix = "${var.team_name}-"
  subnet_id = "${element(aws_subnet.publicsubnets.*.id, 0)}"
  vpc_id = "${aws_vpc.vpc.id}"
}
