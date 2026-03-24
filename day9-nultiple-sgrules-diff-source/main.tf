variable "sg-rule" {
    description = "Allow multiple sgrules with diff source"
    type = map(string)
    default = {
        22 = "203.0.113.0/24"
        80 = "0.0.0.0/0"
        443 = "0.0.0.0/0"
        8080 = "10.0.1.0/24"
        3389 = "10.0.2.0/24"
        3000 = "10.0.3.0/24"
    }
      
}

resource "aws_security_group" "sg" {
    name = "private-sg-rule"
    description = "Allow"

    dynamic "ingress" {
        for_each = var.sg-rule
        content {
            description = "Allow ports ${ingress.key}"
            from_port = ingress.key
            to_port = ingress.key
            protocol ="tcp"
            cidr_blocks = [ingress.value]
        }
    }

        egress {
            from_port = 0
            to_port = 0
            protocol = "-1"
            cidr_blocks = ["0.0.0.0/0"]
        }

        tags = {
        Name = "Private-sg-rule"
        }
}

    
