output "simian_army_public_ip" {
  value = "${module.simian_army.public_ip}"
}

output "elb_dns_name" {
  value = "${aws_elb.elb.dns_name}"
}
