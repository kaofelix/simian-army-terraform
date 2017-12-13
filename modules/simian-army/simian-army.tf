resource "aws_iam_instance_profile" "simian_army_profile" {
  name = "chaos_monkey_profile"
  role = "${aws_iam_role.simian_army_role.name}"
}

resource "aws_iam_role" "simian_army_role" {
  name = "chaos_monkey_role"
  path = "/"

  assume_role_policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Action": "sts:AssumeRole",
            "Principal": {
               "Service": "ec2.amazonaws.com"
            },
            "Effect": "Allow",
            "Sid": ""
        }
    ]
}
EOF
}

resource "aws_security_group" "simian_army_sg" {
  name = "Allow chaos monkey to connect to internet"
  vpc_id = "${var.vpc_id}"

  egress {
    from_port = 0
    protocol = "-1"
    to_port = 0
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port = 8080
    protocol = "tcp"
    to_port = 8080
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags {
    Name = "${var.name_prefix}chaos-monkey-instance-sg"
  }
}

resource "aws_iam_role_policy_attachment" "simian_army_role_ec2_full_access" {
  role       = "${aws_iam_role.simian_army_role.name}"
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2FullAccess"
}

resource "aws_instance" "simian_army" {
  subnet_id = "${var.subnet_id}"
  ami = "${var.ami_id}"
  instance_type = "${var.instance_type}"
  key_name = "${var.sshkeyname}"
  user_data = "${data.template_file.monkey_user_data.rendered}"
  associate_public_ip_address = true
  iam_instance_profile = "${aws_iam_instance_profile.simian_army_profile.id}"
  vpc_security_group_ids = ["${aws_security_group.sshaccess.id}", "${aws_security_group.simian_army_sg.id}"]

  tags {
    Name = "${var.name_prefix}simian_army"
  }

  lifecycle {
    create_before_destroy = true
  }
}

data "template_file" "monkey_user_data" {
  template = "${file("${path.module}/templates/simian-army-userdata.tpl")}"

  vars {
    recorder_sdb_domain = "${var.recorder_sdb_domain}"
    client_localdb_enabled = "${var.client_localdb_enabled}"
    client_cloudformationmode_enabled = "${var.client_cloudformationmode_enabled}"
    scheduler_frequency = "${var.scheduler_frequency}"
    scheduler_frequencyunit = "${var.scheduler_frequencyunit}"
    scheduler_threads = "${var.scheduler_threads}"
    calendar_openhour = "${var.calendar_openhour}"
    calendar_closehour = "${var.calendar_closehour}"
    calendar_timezone = "${var.calendar_timezone}"
    calendar_ismonkeytime = "${var.calendar_ismonkeytime}"
    chaos_leashed = "${var.chaos_leashed}"
    chaos_burnmoney = "${var.chaos_burnmoney}"
    chaos_terminateondemand_enabled = "${var.chaos_terminateondemand_enabled}"
    chaos_mandatorytermination_enabled = "${var.chaos_mandatorytermination_enabled}"
    chaos_mandatorytermination_windowindays = "${var.chaos_mandatorytermination_windowindays}"
    chaos_mandatorytermination_defaultprobability = "${var.chaos_mandatorytermination_defaultprobability}"
    chaos_asg_enabled = "${var.chaos_asg_enabled}"
    chaos_asg_probability = "${var.chaos_asg_probability}"
    chaos_asg_maxterminationsperday = "${var.chaos_asg_maxterminationsperday}"
    chaos_asgtag_key = "${var.chaos_asgtag_key}"
    chaos_asgtag_value = "${var.chaos_asgtag_value}"
    chaos_shutdowninstance_enabled = "${var.chaos_shutdowninstance_enabled}"
    chaos_blockallnetworktraffic_enabled = "${var.chaos_blockallnetworktraffic_enabled}"
    chaos_detachvolumes_enabled = "${var.chaos_detachvolumes_enabled}"
    chaos_burncpu_enabled = "${var.chaos_burncpu_enabled}"
    chaos_burnio_enabled = "${var.chaos_burnio_enabled}"
    chaos_killprocesses_enabled = "${var.chaos_killprocesses_enabled}"
    chaos_nullroute_enabled = "${var.chaos_nullroute_enabled}"
    chaos_failec2_enabled = "${var.chaos_failec2_enabled}"
    chaos_faildns_enabled = "${var.chaos_faildns_enabled}"
    chaos_faildynamodb_enabled = "${var.chaos_faildynamodb_enabled}"
    chaos_fails3_enabled = "${var.chaos_fails3_enabled}"
    chaos_filldisk_enabled = "${var.chaos_filldisk_enabled}"
    chaos_networkcorruption_enabled = "${var.chaos_networkcorruption_enabled}"
    chaos_networklatency_enabled = "${var.chaos_networklatency_enabled}"
    chaos_networkloss_enabled = "${var.chaos_networkloss_enabled}"
    chaos_notification_global_enabled = "${var.chaos_notification_global_enabled}"
  }
}
