variable "vpc_id" {
  type = "string"
}

variable "subnet_id" {
  type = "string"
}

variable "ami_id" {
  type = "string"
}

variable "instance_type" {
  type = "string"
  default = "t2.nano"
}

variable "sshkeyname" {
  type = "string"
}

variable "name_prefix" {
  default = ""
  type = "string"
}

# Simian Army Client Config
variable "recorder_sdb_domain" {
  default = ""
}

variable "client_localdb_enabled" {
  default = "true"
}

variable "client_cloudformationmode_enabled" {
  default = "false"
}

variable "scheduler_frequency" {
  default = "1"
}

variable "scheduler_frequencyunit" {
  default = "HOURS"
}

variable "scheduler_threads" {
  default = "1"
}

variable "calendar_openhour" {
  default = "9"
}

variable "calendar_closehour" {
  default = "15"
}

variable "calendar_timezone" {
  default = "America_Los_Angeles"
}

variable "calendar_ismonkeytime" {
  default = "false"
}

# Simian Army Chaos Config
variable "chaos_enabled" {
  default = "true"
}

variable "chaos_leashed" {
  default = "true"
}

variable "chaos_burnmoney" {
  default = "false"
}

variable "chaos_terminateondemand_enabled" {
  default = "false"
}

variable "chaos_mandatorytermination_enabled" {
  default = "false"
}

variable "chaos_mandatorytermination_windowindays" {
  default = ""
}

variable "chaos_mandatorytermination_defaultprobability" {
  default = ""
}

variable "chaos_asg_enabled" {
  default = "false"
}

variable "chaos_asg_probability" {
  default = "1.0"
}

variable "chaos_asg_maxterminationsperday" {
  default = "1.0"
}

variable "chaos_asgtag_key" {
  default = ""
}

variable "chaos_asgtag_value" {
  default = ""
}

variable "chaos_shutdowninstance_enabled" {
  default = "true"
}

variable "chaos_blockallnetworktraffic_enabled" {
  default = "false"
}

variable "chaos_detachvolumes_enabled" {
  default = "false"
}

variable "chaos_burncpu_enabled" {
  default = "false"
}

variable "chaos_burnio_enabled" {
  default = "false"
}

variable "chaos_killprocesses_enabled" {
  default = "false"
}

variable "chaos_nullroute_enabled" {
  default = "false"
}

variable "chaos_failec2_enabled" {
  default = "false"
}

variable "chaos_faildns_enabled" {
  default = "false"
}

variable "chaos_faildynamodb_enabled" {
  default = "false"
}

variable "chaos_fails3_enabled" {
  default = "false"
}

variable "chaos_filldisk_enabled" {
  default = "false"
}

variable "chaos_networkcorruption_enabled" {
  default = "false"
}

variable "chaos_networklatency_enabled" {
  default = "false"
}

variable "chaos_networkloss_enabled" {
  default = "false"
}

variable "chaos_notification_global_enabled" {
  default = "false"
}
