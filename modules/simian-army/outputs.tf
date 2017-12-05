output "public_ip" {
  value = "${aws_instance.simian_army.public_ip}"
}
