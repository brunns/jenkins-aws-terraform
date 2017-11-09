variable "region" {
  description = "The AWS region"
  default     = "us-east-1"
}

variable "ami" {
  description = "The AMI to use"
  type        = "map"

  default = {
    us-east-1 = "ami-82cfb894" # CentOS 6

    # us-east-1 = "ami-6057e21a" # Amazon Linux
  }
}

variable "jenkins_version" {}
variable "ec2_plugin_version" {}
