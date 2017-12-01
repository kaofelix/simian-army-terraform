output "chaos_monkey_public_ip" {
  value = "${aws_instance.chaos_monkey.public_ip}"
}
