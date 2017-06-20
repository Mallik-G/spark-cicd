variable "AWS_REGION" {
  default = "eu-west-2"
}
variable "PATH_TO_PRIVATE_KEY" {
  default = "mykey"
}
variable "PATH_TO_PUBLIC_KEY" {
  default = "mykey.pub"
}
variable "AMIS" {
  type = "map"
  default = {
    eu-west-1 = "ami-799b841f"
    eu-west-2 = "ami-9e5640fa"
    eu-entral-1 = "ami-fc5bff93"
  }
}
variable "INSTANCE_DEVICE_NAME" {
  default = "/dev/xvdh"
}
variable "JENKINS_VERSION" {
  default = " 2.46.2"
}

variable "APP_INSTANCE_COUNT" {
  default = "0"
}
