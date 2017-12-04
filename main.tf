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

  # Example config:
  # Unleash the monkey to attack ASGs once every minute with 50% chance
  calendar_ismonkeytime = "true"
  chaos_leashed = "false"
  chaos_asg_enabled = "true"
  scheduler_frequency = "1"
  scheduler_frequencyunit = "MINUTES"
  chaos_asg_probability = "180.0"
}
