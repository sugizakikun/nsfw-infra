variable "vpc_id" {
  default = "vpc-XXXXXXXXXXXXX"
}

variable "public_subnet_ids" {
  default = ["subnet-XXXXXXXXXXXXX"] 
}

variable "nsfw_api_task" {
    default = "arn:aws:ecs:us-east-1:XXXXXXXXXXXX:task-definition/nsfw-api-task:1"
}