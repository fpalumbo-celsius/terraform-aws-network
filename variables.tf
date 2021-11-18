variable "region" {
    type = string
}

variable "bastion_ami_id" {
    type = string
    default = ""
}

variable "cidr_block" {
    type = string
    default = "0.0.0.0"
}

variable "belgrade_vpn_ip" {
    type = string
    default = "109.245.237.30"
}

variable "belgrade_vpn_ip_subnet" {
    type = string
    default = "172.18.3.0/24"
}

variable "vpn_cidr_blocks" {
    type = list
    default = ["35.156.136.248/32", "109.245.237.30/32"]
}

variable "environment" {
    type = string
    default = "staging-new-test"
}

variable "effort" {
    type = string
    default = "core"
}

variable "public_subnets" {
    type = list
    default = []
}

variable "private_subnets" {
    type = list
    default = []
}

variable "internal_subnets" {
    type = list
    default = []
}

variable "management_subnet" {
    type = map
    default = {}
}

variable "bastion_public_key" {
    type = string
    default = ""
}

variable "internal_public_key" {
    type = string
    default = ""
}
