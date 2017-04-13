# ============================================================================
# settings unrelated for elastic beanstalk ;)

variable "cname_prefix" {}

# ============================================================================
# required settings

variable "vpc_id" {}

variable "instance_role" {}

variable "subnets" {
  type = "list"
}

# sometimes required, don't know why
variable "ebs_service_role" {}

# ============================================================================
# settings for the ASG (hosts)

variable "asg_instance_type" {
  default = "t2.micro"
}

variable "asg_size_min" {
  default = "1"
}

variable "asg_size_max" {
  default = "25"
}

variable "asg_size_desired" {
  default = "2"
}

# yup, this is a thing. https://is.gd/QIH6IP
variable "asg_zones" {
  default = "Any 2"
}

variable "asg_security_groups" {
  type    = "list"
  default = []
}

# ============================================================================
# settings for scaling triggers

# Metric used for your Auto Scaling trigger.
# Valid values:
#   CPUUtilization, NetworkIn, NetworkOut, DiskWriteOps, DiskReadBytes,
#   DiskReadOps, DiskWriteBytes, Latency, RequestCount, HealthyHostCount,
#   UnhealthyHostCount
variable "asg_trigger_measure_name" {
  default = "CPUUtilization"
}

# Amount of time, in minutes, a metric can be beyond its defined limit
# (as specified in the UpperThreshold and LowerThreshold) before the trigger
# fires.
variable "asg_trigger_breach_duration" {
  default = "5"
}

# If the measurement falls below this number for the breach duration,
# a trigger is fired. (this default is for CPU usage)
variable "asg_trigger_lower_threshold" {
  default = "70"
}

# If the measurement is higher than this number for the breach duration,
# a trigger is fired. (this default is for CPU usage)
variable "asg_trigger_upper_threshold" {
  default = "85"
}

# How many Amazon EC2 instances to remove when performing a scaling activity.
variable "asg_trigger_lower_breach_scale_increment" {
  default = "-2"
}

# How many Amazon EC2 instances to add when performing a scaling activity.
variable "asg_trigger_upper_breach_scale_increment" {
  default = "4"
}

# Specifies how frequently Amazon CloudWatch measures the metrics for your
# trigger.
variable "asg_trigger_period" {
  default = "5"
}

# Statistic the trigger should use, such as Average.
# valid values: Minimum, Maximum, Sum, Average
variable "asg_trigger_statistic" {
  default = "Average"
}

# Unit for the trigger measurement, such as Bytes.
# valid values:
#     Seconds, Percent, Bytes, Bits, Count, Bytes/Second, Bits/Second,
#     Count/Second, None
variable "asg_trigger_unit" {
  default = "Percent"
}

# ============================================================================
# ELB settings

variable "elb_subnets" {
  type = "list"
}

variable "elb_cross_zone" {
  default = "true"
}

# "internal" for vpc only, "external" for public ELBs
variable "elb_scheme" {
  default = "internal"
}

variable "elb_drain_connections" {
  default = "true"
}

# ============================================================================
# docker settings


# ============================================================================
# other stuff


# tbd

