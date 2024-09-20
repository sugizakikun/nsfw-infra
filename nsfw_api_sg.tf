module "nsfw_api_sg" {
    source      = "./security_group"
    name        = "nsfw_api_sg"
    vpc_id      = var.vpc_id
    port        = 5000
    protocol    = "tcp" 
}