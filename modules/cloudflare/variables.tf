variable "zone_domain_name" {
  type = string
}

variable "record_name" {
  type = string
}

variable "record_value" {
  type = string
}

variable "record_type" {
  type    = string
  default = "A"
}

variable "proxied" {
  type    = bool
  default = false
}

variable "allow_overwrite" {
  type    = bool
  default = false
}
