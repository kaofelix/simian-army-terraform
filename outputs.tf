output "chaos_monkey_public_ip" {
  value = "${module.chaos_monkey.public_ip}"
}

output "elb_dns_name" {
  value = "${aws_elb.yocto.dns_name}"
}
