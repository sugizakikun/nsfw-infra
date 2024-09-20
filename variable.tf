variable "vpc_id" {
  default = "vpc-XXXXXXXXXXXXX"
}

variable "public_subnet_ids" {
  default = ["subnet-XXXXXXXXXXXXX"] 
}

variable "eip_alloc" {
  default = "eipalloc-XXXXXXXXXXXXXXXXX"
}