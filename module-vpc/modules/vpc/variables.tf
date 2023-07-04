variable  "cidr" {
  type        = string
  default     = ""
  description = "1"
}

variable "name" {
  type        = string
  default     = ""
  description = "2"
}

variable "private_subnets" {
  type        = string
  default     = ""
  description = "3"
}

variable "public_subnets" {
  type        = string
  default     = ""
  description = "4"
}

variable "az" {
  type        = list(string)
  default     = []
  description = "5"
}

variable "cidr_rt" {
  type        = string
  default     = ""
  description = "5"
}


