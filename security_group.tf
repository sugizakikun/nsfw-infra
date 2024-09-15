resource "aws_security_group" "nsfw_api_sg"{
    name = "nsfw_api_sg"
    vpc_id = var.vpc_id
}

resource "aws_security_group_rule" "ingress"{
    type        = "ingress"
    from_port   = 5000
    to_port     = 5000
    protocol    = "tcp"
    cidr_blocks  = ["0.0.0.0/0"]
    security_group_id = aws_security_group.nsfw_api_sg.id
}

resource "aws_security_group_rule" "egress" {
    type        = "egress"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks  = ["0.0.0.0/0"]
    security_group_id = aws_security_group.nsfw_api_sg.id
}